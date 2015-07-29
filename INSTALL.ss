#
# This script (INSTALL.ss) creates an INSTALL file from the INSTALL.texi
# file by adding housekeeping commands and using makeinfo --plaintext.
#

set -e
trap 'rm -f INSTALL.tmp1 INSTALL.tmp2' EXIT
echo \\input texinfo >INSTALL.tmp1
echo @setfilename foo >>INSTALL.tmp1
echo @documentencoding UTF-8 >>INSTALL.tmp1
cat INSTALL.texi >>INSTALL.tmp1
echo @bye >>INSTALL.tmp1
makeinfo --plaintext INSTALL.tmp1 >INSTALL.tmp2
mv INSTALL.tmp2 INSTALL

#
# The authors of this file have waived all copyright and
# related or neighboring rights to the extent permitted by
# law as described by the CC0 1.0 Universal Public Domain
# Dedication. You should have received a copy of the full
# dedication along with this file, typically as a file
# named <CC0-1.0.txt>. If not, it may be available at
# <https://creativecommons.org/publicdomain/zero/1.0/>.
#
