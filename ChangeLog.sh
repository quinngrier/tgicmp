#
# This script (ChangeLog.sh) creates a ChangeLog file for Autotools by
# using git log to retrieve the commits induced by HEAD. Just add this
# script to your repository, use it to create your first ChangeLog file,
# add that to your repository, and repeat when making a commit that is
# intended to be used to create a distribution or git archive tarball.
#
# You can optionally add a file named ChangeLog.top, which will be
# included at the top of the ChangeLog file with a blank line following
# it. You can also write this file as a Texinfo document by renaming it
# to ChangeLog.top.texi, which will be fed through makeinfo --plaintext
# before being included.
#
# Similarly, you can optionally add a ChangeLog.bot(.texi) file, which
# will be included at the bottom with a blank line preceding it.
#

set -e
trap 'rm -f ChangeLog.tmp1 ChangeLog.tmp2' EXIT

#
# Process the ChangeLog.top(.texi) file.
#

if test -f ChangeLog.top; then
  cp ChangeLog.top ChangeLog.tmp1
  echo >>ChangeLog.tmp1
elif test -f ChangeLog.top.texi; then
  makeinfo --plaintext ChangeLog.top.texi >ChangeLog.tmp1
  echo >>ChangeLog.tmp1
else
  cp /dev/null ChangeLog.tmp1
fi

x='format:Commit: %H%nAuthor: %an <%ae>%nDate:   %ad UTC%n%n    %s%n'
TZ=UTC git log --author-date-order --date=local \
               --pretty="$x" >ChangeLog.tmp2
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
     }' ChangeLog.tmp2 >>ChangeLog.tmp1

if test -f ChangeLog.bot; then
  echo >>ChangeLog.tmp1
  cat ChangeLog.bot >>ChangeLog.tmp1
elif test -f ChangeLog.bot.texi; then
  makeinfo --plaintext ChangeLog.bot.texi >ChangeLog.tmp2
  echo >>ChangeLog.tmp1
  cat ChangeLog.tmp2 >>ChangeLog.tmp1
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
