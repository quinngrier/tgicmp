#
# This script (AUTHORS.texi.sh) creates an AUTHORS.texi file by using
# git log to get the chronological list of authors reachable from HEAD.
#
# If the AUTHORS.texi.top file exists, it will be added to the top of
# the AUTHORS.texi file. If the AUTHORS.texi.bot file exists, it will be
# added to the bottom of the AUTHORS.texi file.
#
# If the AUTHORS.texi.fix file exists, it will be used to sanitize names
# and email addresses in the AUTHORS.texi file. It must contain awk code
# that repeatedly calls the fix(ere, repl) function, which acts like the
# gsub function but applies to each name and email address. For example,
# the following code will replace each 0x01 and 0x02 byte with U+FFFD:
#
#   fix("\001", "\357\277\275")
#   fix("\002", "\357\277\275")
#

set -e
trap 'rm -f AUTHORS.texi.tmp1 AUTHORS.texi.tmp2 AUTHORS.texi.tmp3' EXIT

if test -f AUTHORS.texi.top; then
  cp AUTHORS.texi.top AUTHORS.texi.tmp1
else
  cp /dev/null AUTHORS.texi.tmp1
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
# least stop the AUTHORS.texi file from being permanently damaged.
#

git log --author-date-order \
        --pretty=%an%n%ae --reverse >AUTHORS.texi.tmp2

if test -f AUTHORS.texi.bot; then
  cat AUTHORS.texi.bot >>AUTHORS.texi.tmp1
fi

#
# Finally, rename AUTHORS.texi.tmp1 to AUTHORS.texi.
#

mv AUTHORS.texi.tmp1 AUTHORS.texi
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
