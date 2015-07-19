#
# This script generates an AUTHORS file by using git log. Just add this
# script to your repository, use it to generate your first AUTHORS file,
# add that to your repository, and repeat as needed. You can also add a
# file named AUTHORS.top that will be included at the beginning of the
# AUTHORS file.
#

set -e
trap 'rm -f AUTHORS.tmp1 AUTHORS.tmp2' EXIT

git log --pretty='tformat:%an <%ae>' >AUTHORS.tmp1
sed 's/ <>$//' AUTHORS.tmp1 >AUTHORS.tmp2
LC_ALL=C sort -u AUTHORS.tmp2 >AUTHORS.tmp1

if test -f AUTHORS.top; then
  cat AUTHORS.top AUTHORS.tmp1 >AUTHORS.tmp2
else
  mv AUTHORS.tmp1 AUTHORS.tmp2
fi
mv AUTHORS.tmp2 AUTHORS

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
