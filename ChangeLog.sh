#
# This script (ChangeLog.sh) creates a ChangeLog file for Autotools by
# using git log to retrieve the commits induced by HEAD. Just add this
# script to your repository, use it to create your first ChangeLog file,
# add that to your repository, and update it when making a commit that
# is intended to provide a distribution or git archive tarball.
#
# You can optionally add a file named ChangeLog.top, which will be
# included at the top of the ChangeLog file with a blank line following
# it. You can also write it in Texinfo by naming it ChangeLog.top.texi,
# which will be fed through makeinfo --plaintext before being included.
#
# Similarly, you can optionally add a ChangeLog.bot(.texi) file, which
# will be included at the bottom of the ChangeLog file with a blank line
# preceding it.
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

#
# Process the commits.
#
# We want the author dates in YYYY-MM-DD HH:MM:SS UTC form, but it
# appears that git log only respects TZ=UTC when it is invoked with
# --date=local --pretty=%ad. This format is the same as the format of
# the asctime function except that single-digit day numbers have only
# one preceding space instead of two. We convert this format to our
# desired format as follows:
#
#      Wed Jul 1 12:34:56 2015
#   -> 2015-Jul-1 12:34:56
#   -> 2015-07-1 12:34:56
#   -> 2015-07-01 12:34:56
#

x='format:Commit: %H%nAuthor: %an <%ae>%nDate:   %ad +0000%n%n    %s%n'
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
