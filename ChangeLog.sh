#
# This script generates a ChangeLog file by using git log. Just add this
# script to your repository, use it to generate your first ChangeLog
# file, add that to your repository, and repeat as needed. You can also
# add a file named ChangeLog.top.texi that will be included at the beginning
# of the ChangeLog file.
#
# We want the author YYYY-MM-DD in UTC, but the only git log author date
# format that respects TZ=UTC is %ad. So we hopefully improve the chance
# that it's in standard C form with LC_ALL=C and convert it like this:
#
#      Wed Jul 1 12:34:56 2015
#   -> 2015-Jul-1
#   -> 2015-Jul-01
#   -> 2015-07-01
#

set -e
trap 'rm -f ChangeLog.tmp1 ChangeLog.tmp2 ChangeLog.tmp3' EXIT

pretty='Commit: %H%nAuthor: %an <%ae>%nDate:   %ad UTC%n%n    %s%n'
TZ=UTC git log --author-date-order --date=local \
               --pretty="$pretty" >ChangeLog.tmp1
sed '/^Author:/s/ <>$//
     /^Date:/{
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
     }' ChangeLog.tmp1 >ChangeLog.tmp2

if test -f ChangeLog.top.texi; then
  makeinfo --plaintext ChangeLog.top.texi >ChangeLog.tmp3
  cat ChangeLog.tmp3 ChangeLog.tmp2 >ChangeLog.tmp1
else
  mv ChangeLog.tmp2 ChangeLog.tmp1
fi
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
