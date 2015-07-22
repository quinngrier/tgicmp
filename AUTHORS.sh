#
# This script (AUTHORS.sh) creates an AUTHORS file for Autotools by
# using git log to retrieve the authors induced by HEAD. Just add this
# script to your repository, use it to create your first AUTHORS file,
# add that to your repository, and update it when making a commit that
# is intended to provide a distribution or git archive tarball.
#
# You can optionally add a file named AUTHORS.top, which will be
# included at the top of the AUTHORS file with a blank line following
# it. You can also write it in Texinfo by naming it AUTHORS.top.texi,
# which will be fed through makeinfo --plaintext before being included.
#
# Similarly, you can optionally add an AUTHORS.bot(.texi) file, which
# will be included at the bottom of the AUTHORS file with a blank line
# preceding it.
#
# You can optionally add a file named AUTHORS.fix to sanitize names and
# email addresses in the AUTHORS file. This is useful to repair strange
# bytes that would cause the file to not be identified as UTF-8 text by
# file type identification algorithms or to contain ill-formed UTF-8
# byte sequences.
#
# The AUTHORS.fix file should contain some awk code that calls the
# function fix(ere, repl) some number of times. The function behaves
# like the gsub function and is applied to each name and email address.
# Here is an example file that will replace each 0x01 or 0x02 byte with
# the Unicode replacement character (U+FFFD):
#
#   fix("\001", "\357\277\275")
#   fix("\002", "\357\277\275")
#

set -e
trap 'rm -f AUTHORS.tmp1 AUTHORS.tmp2 AUTHORS.tmp3' EXIT

#
# Process AUTHORS.top(.texi) into AUTHORS.tmp1. This is the file that
# we'll be accumulating into and eventually renaming to AUTHORS.
#

if test -f AUTHORS.top; then
  cp AUTHORS.top AUTHORS.tmp1
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

git log --author-date-order --pretty=%an%n%ae --reverse >AUTHORS.tmp2

#
# We use a single awk script to remove the duplicate authors, apply the
# fixes from AUTHORS.fix, and do the formatting. Note the use of "\n" to
# properly simulate a two-dimensional array: if we were to use something
# that is permitted to appear in a name or email address, it could cause
# two different authors to coalesce.
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

LC_COLLATE=C LC_CTYPE=C \
  awk -f AUTHORS.tmp3 AUTHORS.tmp2 >>AUTHORS.tmp1

#
# Process the AUTHORS.bot(.texi) file.
#

if test -f AUTHORS.bot; then
  echo >>AUTHORS.tmp1
  cat AUTHORS.bot >>AUTHORS.tmp1
elif test -f AUTHORS.bot.texi; then
  makeinfo --plaintext AUTHORS.bot.texi >AUTHORS.tmp2
  echo >>AUTHORS.tmp1
  cat AUTHORS.tmp2 >>AUTHORS.tmp1
fi

#
# Finish up.
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
