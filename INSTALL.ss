#
# This script (INSTALL.ss) creates an INSTALL file from the INSTALL.texi
# file by adding housekeeping commands and using makeinfo --plaintext.
#
# If the INSTALL.top file exists, it will be added to the top of the
# INSTALL file with a trailing blank line and lines starting with "#"
# removed. Otherwise, if the INSTALL.top.texi file exists, it will be
# given to makeinfo --plaintext and added in the same way, but without
# line removal. This also occurs for the INSTALL.bot(.texi) files, but
# adding to the bottom of the INSTALL file with a leading blank line.
#

set -e
trap 'rm -f INSTALL.tmp1 INSTALL.tmp2' EXIT

if test -f INSTALL.top; then
  LC_COLLATE=C LC_CTYPE=C \
    sed '/^#/d' INSTALL.top >INSTALL.tmp1
  echo >>INSTALL.tmp1
elif test -f INSTALL.top.texi; then
  makeinfo --plaintext INSTALL.top.texi >INSTALL.tmp1
  echo >>INSTALL.tmp1
else
  cp /dev/null INSTALL.tmp1
fi

echo \\input texinfo >INSTALL.tmp2
echo @setfilename foo >>INSTALL.tmp2
echo @documentencoding UTF-8 >>INSTALL.tmp2
cat INSTALL.texi >>INSTALL.tmp2
echo @bye >>INSTALL.tmp2
makeinfo --plaintext INSTALL.tmp2 >>INSTALL.tmp1

if test -f INSTALL.bot; then
  echo >>INSTALL.tmp1
  LC_COLLATE=C LC_CTYPE=C \
    sed '/^#/d' INSTALL.bot >>INSTALL.tmp1
elif test -f INSTALL.bot.texi; then
  echo >>INSTALL.tmp1
  makeinfo --plaintext INSTALL.bot.texi >>INSTALL.tmp1
fi

mv INSTALL.tmp1 INSTALL

#
# The authors of this file have waived all copyright and
# related or neighboring rights to the extent permitted by
# law as described by the CC0 1.0 Universal Public Domain
# Dedication. You should have received a copy of the full
# dedication along with this file, typically as a file
# named <CC0-1.0.txt>. If not, it may be available at
# <https://creativecommons.org/publicdomain/zero/1.0/>.
#
