#
# This script (AUTHORS.sh) creates an AUTHORS file from the AUTHORS.texi
# file by adding housekeeping commands and using makeinfo --plaintext.
#
# If the AUTHORS.top file exists, it will be added to the top of the
# AUTHORS file with a trailing blank line and lines starting with "#"
# removed. Otherwise, if the AUTHORS.top.texi file exists, it will be
# given to makeinfo --plaintext and added in the same way, but without
# line removal. This also occurs for the AUTHORS.bot(.texi) files, but
# adding to the bottom of the AUTHORS file with a leading blank line.
#

set -e
trap 'for i in 1 2 3; do rm -f AUTHORS.tmp$i; done' EXIT

if test -f AUTHORS.top; then
  LC_COLLATE=C LC_CTYPE=C \
    sed '/^#/d' AUTHORS.top >AUTHORS.tmp1
  echo >>AUTHORS.tmp1
elif test -f AUTHORS.top.texi; then
  makeinfo --plaintext AUTHORS.top.texi >AUTHORS.tmp1
  echo >>AUTHORS.tmp1
else
  cp /dev/null AUTHORS.tmp1
fi

#
# Retrieve the chronological list of authors with git log (see the git
# log documentation for --author-date-order). This order is reasonably
# intuitive and we only need git to guarantee that we can use a unique
# delimiter (the newline character) to parse and remove duplicates.
#
# Trying to do an "alphabetical" sort with Unicode involved would be a
# whole new can of worms. We could also make git do most of the work by
# using git shortlog --email --summary, but that uses .mailmap (see the
# git shortlog documentation). We don't want to use .mailmap because we
# want our authors list to reflect history, not to be open to revisions.
#
# Note that git log will do its best to give us well-formed UTF-8 data
# by default (see the git log documentation for --encoding), but there
# are no guarantees. If a messy commit gets into our published history,
# we're stuck with it. This is the reason for the .fix file: we can at
# least stop the AUTHORS file from being permanently damaged.
#

git log --author-date-order \
        --pretty=%an%n%ae --reverse >AUTHORS.tmp2

#
# We use a single awk script to remove the duplicate authors, apply the
# fixes, and do the formatting. Note the use of "\n" to properly provide
# a two-dimensional array: if we were to use something that is permitted
# to appear in a name or email address, we would risk having two authors
# coalesce.
#

cat >AUTHORS.tmp3 <<'EOF'
  NR % 2 == 1 {
    name = $0
  }
  NR % 2 == 0 {
    email = $0
    combo = name "\n" email
    if (!seen[combo]) {
      seen[combo] = 1
      apply_fixes()
      print name " <" email ">"
    }
  }
  function fix(ere, repl) {
    gsub(ere, repl, name)
    gsub(ere, repl, email)
  }
  function apply_fixes() {
EOF

if test -f AUTHORS.fix; then
  cat AUTHORS.fix >>AUTHORS.tmp3
fi

echo } >>AUTHORS.tmp3

#
# We want awk to use plain old bytes for input, output, and string
# comparisons. Setting LC_COLLATE=C and LC_CTYPE=C guarantees this. We
# could lazily set LC_ALL=C to get a superset of this, but we'd rather
# just set the LC_* variables that we need. In particular, LC_MESSAGES
# affects error messages, so we want to leave that alone.
#

LC_COLLATE=C LC_CTYPE=C \
  awk -f AUTHORS.tmp3 AUTHORS.tmp2 >>AUTHORS.tmp1

if test -f AUTHORS.bot; then
  echo >>AUTHORS.tmp1
  LC_COLLATE=C LC_CTYPE=C \
    sed '/^#/d' AUTHORS.bot >>AUTHORS.tmp1
elif test -f AUTHORS.bot.texi; then
  makeinfo --plaintext AUTHORS.bot.texi >AUTHORS.tmp2
  echo >>AUTHORS.tmp1
  cat AUTHORS.tmp2 >>AUTHORS.tmp1
fi

#
# Finally, rename AUTHORS.tmp1 to AUTHORS.
#

mv AUTHORS.tmp1 AUTHORS
exit 0

#
# The authors of this file have waived all copyright and
# related or neighboring rights to the extent permitted by
# law as described by the CC0 1.0 Universal Public Domain
# Dedication. You should have received a copy of the full
# dedication along with this file, typically as a file
# named <CC0-1.0.txt>. If not, it may be available at
# <https://creativecommons.org/publicdomain/zero/1.0/>.
#
