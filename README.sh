#
# This script (README.sh) creates a README file from the README.texi
# file by using makeinfo --plaintext.
#
# If the README.top file exists, it will be added to the top of the
# README file with a trailing blank line and lines starting with "#"
# removed. Otherwise, if the README.top.texi file exists, it will be
# given to makeinfo --plaintext and added in the same way, but without
# line removal. This also occurs for the README.bot(.texi) files, but
# adding to the bottom of the README file with a leading blank line.
#

set -e
trap 'rm -f README.tmp1' EXIT

if test -f README.top; then
  LC_COLLATE=C LC_CTYPE=C \
    sed '/^#/d' README.top >README.tmp1
  echo >>README.tmp1
elif test -f README.top.texi; then
  makeinfo --plaintext README.top.texi >README.tmp1
  echo >>README.tmp1
else
  cp /dev/null README.tmp1
fi

makeinfo --plaintext README.texi >>README.tmp1

if test -f README.bot; then
  echo >>README.tmp1
  LC_COLLATE=C LC_CTYPE=C \
    sed '/^#/d' README.bot >>README.tmp1
elif test -f README.bot.texi; then
  echo >>README.tmp1
  makeinfo --plaintext README.bot.texi >>README.tmp1
fi

mv README.tmp1 README

#
# The authors of this file have waived all copyright and
# related or neighboring rights to the extent permitted by
# law as described by the CC0 1.0 Universal Public Domain
# Dedication. You should have received a copy of the full
# dedication along with this file, typically as a file
# named <CC0-1.0.txt>. If not, it may be available at
# <https://creativecommons.org/publicdomain/zero/1.0/>.
#
