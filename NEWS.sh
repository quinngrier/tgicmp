#
# This script (NEWS.sh) creates a NEWS file from the NEWS.texi
# file by adding housekeeping commands and using makeinfo --plaintext.
#
# If the NEWS.top file exists, it will be added to the top of the
# NEWS file with a trailing blank line and lines starting with "#"
# removed. Otherwise, if the NEWS.top.texi file exists, it will be
# given to makeinfo --plaintext and added in the same way, but without
# line removal. This also occurs for the NEWS.bot(.texi) files, but
# adding to the bottom of the NEWS file with a leading blank line.
#

set -e
trap 'rm -f NEWS.tmp1 NEWS.tmp2' EXIT

if test -f NEWS.top; then
  LC_COLLATE=C LC_CTYPE=C \
    sed '/^#/d' NEWS.top >NEWS.tmp1
  echo >>NEWS.tmp1
elif test -f NEWS.top.texi; then
  makeinfo --plaintext NEWS.top.texi >NEWS.tmp1
  echo >>NEWS.tmp1
else
  cp /dev/null NEWS.tmp1
fi

echo \\input texinfo >NEWS.tmp2
echo @setfilename foo >>NEWS.tmp2
echo @documentencoding UTF-8 >>NEWS.tmp2
cat NEWS.texi >>NEWS.tmp2
echo @bye >>NEWS.tmp2
makeinfo --plaintext NEWS.tmp2 >>NEWS.tmp1

if test -f NEWS.bot; then
  echo >>NEWS.tmp1
  LC_COLLATE=C LC_CTYPE=C \
    sed '/^#/d' NEWS.bot >>NEWS.tmp1
elif test -f NEWS.bot.texi; then
  echo >>NEWS.tmp1
  makeinfo --plaintext NEWS.bot.texi >>NEWS.tmp1
fi

mv NEWS.tmp1 NEWS

#
# The authors of this file have waived all copyright and
# related or neighboring rights to the extent permitted by
# law as described by the CC0 1.0 Universal Public Domain
# Dedication. You should have received a copy of the full
# dedication along with this file, typically as a file
# named <CC0-1.0.txt>. If not, it may be available at
# <https://creativecommons.org/publicdomain/zero/1.0/>.
#
