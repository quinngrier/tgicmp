#
# This script (MIRRORS.sh) creates a MIRRORS file from the MIRRORS.texi
# file by adding housekeeping commands and using makeinfo --plaintext.
#
# If the MIRRORS.top file exists, it will be added to the top of the
# MIRRORS file with a trailing blank line and lines starting with "#"
# removed. Otherwise, if the MIRRORS.top.texi file exists, it will be
# given to makeinfo --plaintext and added in the same way, but without
# line removal. This also occurs for the MIRRORS.bot(.texi) files, but
# adding to the bottom of the MIRRORS file with a leading blank line.
#

set -e
trap 'rm -f MIRRORS.tmp1 MIRRORS.tmp2' EXIT

if test -f MIRRORS.top; then
  LC_COLLATE=C LC_CTYPE=C \
    sed '/^#/d' MIRRORS.top >MIRRORS.tmp1
  echo >>MIRRORS.tmp1
elif test -f MIRRORS.top.texi; then
  makeinfo --plaintext MIRRORS.top.texi >MIRRORS.tmp1
  echo >>MIRRORS.tmp1
else
  cp /dev/null MIRRORS.tmp1
fi

echo \\input texinfo >MIRRORS.tmp2
echo @setfilename foo >>MIRRORS.tmp2
echo @documentencoding UTF-8 >>MIRRORS.tmp2
cat MIRRORS.texi >>MIRRORS.tmp2
echo @bye >>MIRRORS.tmp2
makeinfo --plaintext MIRRORS.tmp2 >>MIRRORS.tmp1

if test -f MIRRORS.bot; then
  echo >>MIRRORS.tmp1
  LC_COLLATE=C LC_CTYPE=C \
    sed '/^#/d' MIRRORS.bot >>MIRRORS.tmp1
elif test -f MIRRORS.bot.texi; then
  echo >>MIRRORS.tmp1
  makeinfo --plaintext MIRRORS.bot.texi >>MIRRORS.tmp1
fi

mv MIRRORS.tmp1 MIRRORS

#
# The authors of this file have waived all copyright and
# related or neighboring rights to the extent permitted by
# law as described by the CC0 1.0 Universal Public Domain
# Dedication. You should have received a copy of the full
# dedication along with this file, typically as a file
# named <CC0-1.0.txt>. If not, it may be available at
# <https://creativecommons.org/publicdomain/zero/1.0/>.
#
