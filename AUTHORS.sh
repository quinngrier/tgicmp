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

if test -f AUTHORS.bot; then
  echo >>AUTHORS.tmp1
  LC_COLLATE=C LC_CTYPE=C \
    sed '/^#/d' AUTHORS.bot >>AUTHORS.tmp1
elif test -f AUTHORS.bot.texi; then
  makeinfo --plaintext AUTHORS.bot.texi >AUTHORS.tmp2
  echo >>AUTHORS.tmp1
  cat AUTHORS.tmp2 >>AUTHORS.tmp1
fi

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
