#
# This script (ChangeLog.sh) creates a ChangeLog file by using git log
# to get the reverse chronological list of commits reachable from HEAD.
#
# If the ChangeLog.top file exists, it will be added to the top of the
# ChangeLog file with a trailing blank line and lines starting with "#"
# removed. Otherwise, if the ChangeLog.top.texi file exists, it will be
# given to makeinfo --plaintext and added in the same way, but without
# line removal. This also occurs for the ChangeLog.bot(.texi) files, but
# adding to the bottom of the ChangeLog file with a leading blank line.
#
# If the ChangeLog.fix file exists, it will be used to sanitize names,
# email addresses, and commit subjects in the ChangeLog file. It must
# contain awk code that repeatedly calls the fix(ere, repl) function,
# which acts like the gsub function but applies to each name, email
# address, and commit subject. For example, the following calls will
# replace each 0x01 and 0x02 byte with U+FFFD:
#
#   fix("\001", "\357\277\275")
#   fix("\002", "\357\277\275")
#

set -e
trap 'for i in 1 2; do rm -f ChangeLog.tmp$i; done' EXIT

if test -f ChangeLog.top; then
  sed '/^#/d' ChangeLog.top >ChangeLog.tmp1
  echo >>ChangeLog.tmp1
elif test -f ChangeLog.top.texi; then
  makeinfo --plaintext ChangeLog.top.texi >ChangeLog.tmp1
  echo >>ChangeLog.tmp1
else
  cp /dev/null ChangeLog.tmp1
fi

x='%H%n%an%n%ae%n%ad%n%s'
TZ=UTC git log --author-date-order --date=local \
               --pretty="$x" >ChangeLog.tmp2
sed '/^Date:/{
       s/... \(...\) \(.\{1,2\}\) \(..:..:..\) \(....\)/\4-\1-\2 \3/
       s/Jan/01/
       s/Feb/02/
       s/Mar/03/
       s/Apr/04/
       s/May/05/
       s/Jun/06/
       s/Jul/07/
       s/Aug/08/
       s/Sep/09/
       s/Oct/10/
       s/Nov/11/
       s/Dec/12/
       s/-\(.\) /-0\1 /
     }' ChangeLog.tmp2 >>ChangeLog.tmp1

#
# Process the ChangeLog.bot(.texi) file.
#

if test -f ChangeLog.bot; then
  echo >>ChangeLog.tmp1
  cat ChangeLog.bot >>ChangeLog.tmp1
elif test -f ChangeLog.bot.texi; then
  makeinfo --plaintext ChangeLog.bot.texi >ChangeLog.tmp2
  echo >>ChangeLog.tmp1
  cat ChangeLog.tmp2 >>ChangeLog.tmp1
fi

#
# Finish up.
#

mv ChangeLog.tmp1 ChangeLog
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
