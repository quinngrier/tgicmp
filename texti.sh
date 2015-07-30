#
# This script (texti.sh) creates a $target file from the $target.texi
# file by adding housekeeping commands and using makeinfo --plaintext.
# $target is always set to $1.
#
# If the $target.top file exists, it will be added to the top of the
# $target file with a trailing blank line and lines starting with "#"
# removed. Otherwise, if the $target.top.texi file exists, it will be
# given to makeinfo --plaintext and added in the same way, but without
# line removal. This also occurs for the $target.bot(.texi) files, but
# adding to the bottom of the $target file with a leading blank line.
#

set -e
target="$1"
trap 'rm -f '"$target"'.tmp1 '"$target"'.tmp2' EXIT

if test -f "$target".top; then
  LC_COLLATE=C LC_CTYPE=C \
    sed '/^#/d' "$target".top >"$target".tmp1
  echo >>"$target".tmp1
elif test -f "$target".top.texi; then
  makeinfo --plaintext "$target".top.texi >"$target".tmp1
  echo >>"$target".tmp1
else
  cp /dev/null "$target".tmp1
fi

echo \\input texinfo >"$target".tmp2
echo @setfilename foo >>"$target".tmp2
echo @documentencoding UTF-8 >>"$target".tmp2
cat "$target".texi >>"$target".tmp2
echo @bye >>"$target".tmp2
makeinfo --plaintext "$target".tmp2 >>"$target".tmp1

if test -f "$target".bot; then
  echo >>"$target".tmp1
  LC_COLLATE=C LC_CTYPE=C \
    sed '/^#/d' "$target".bot >>"$target".tmp1
elif test -f "$target".bot.texi; then
  echo >>"$target".tmp1
  makeinfo --plaintext "$target".bot.texi >>"$target".tmp1
fi

mv "$target".tmp1 "$target"

#
# The authors of this file have waived all copyright and
# related or neighboring rights to the extent permitted by
# law as described by the CC0 1.0 Universal Public Domain
# Dedication. You should have received a copy of the full
# dedication along with this file, typically as a file
# named <CC0-1.0.txt>. If not, it may be available at
# <https://creativecommons.org/publicdomain/zero/1.0/>.
#
