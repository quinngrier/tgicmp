#
# This script (NEWS.sh) creates a NEWS file from the NEWS.texi file by
# adding housekeeping commands and using makeinfo --plaintext.
#

set -e
trap 'rm -f NEWS.tmp1 NEWS.tmp2' EXIT
echo \\input texinfo >NEWS.tmp1
echo @setfilename foo >>NEWS.tmp1
echo @documentencoding UTF-8 >>NEWS.tmp1
cat NEWS.texi >>NEWS.tmp1
echo @bye >>NEWS.tmp1
makeinfo --plaintext NEWS.tmp1 >NEWS.tmp2
mv NEWS.tmp2 NEWS

#
# The authors of this file have waived all copyright and
# related or neighboring rights to the extent permitted by
# law as described by the CC0 1.0 Universal Public Domain
# Dedication. You should have received a copy of the full
# dedication along with this file, typically as a file
# named <CC0-1.0.txt>. If not, it may be available at
# <https://creativecommons.org/publicdomain/zero/1.0/>.
#
