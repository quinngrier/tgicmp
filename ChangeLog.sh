#
# This script generates a ChangeLog file by using git log. Just add this
# script to your repository, use it to generate your first ChangeLog
# file, add that to your repository, and repeat as needed.
#

#
# We want the author YYYY-MM-DD in UTC, but the only git log author date
# format that respects TZ=UTC is %ad. So we hopefully improve the chance
# that it's in standard C form with LC_ALL=C and do some parsing work.
#
# Here is an example of how the parsing works:
#
#      Wed Jul 1 12:34:56 2015
#   -> 2015-Jul-1
#   -> 2015-Jul-01
#   -> 2015-07-01
#

set -e
trap 'rm -f ChangeLog.tmp' EXIT
LC_ALL=C TZ=UTC git log --author-date-order --date=local           \
                        --format='format:# %ad %an <%ae>%n* %s.%n' \
                        >ChangeLog.tmp
sed -e 's/^# ... \(...\) \([^ ]*\).\{10\}\(....\)/# \3-\1-\2/' \
    -e 's/^\(# ....-...-\)\(. \)/\10\2/'                       \
    -e 's/^\(# ....-\)Jan/\101/' -e 's/^\(# ....-\)Jul/\107/'  \
    -e 's/^\(# ....-\)Feb/\102/' -e 's/^\(# ....-\)Aug/\108/'  \
    -e 's/^\(# ....-\)Mar/\103/' -e 's/^\(# ....-\)Sep/\109/'  \
    -e 's/^\(# ....-\)Apr/\104/' -e 's/^\(# ....-\)Oct/\110/'  \
    -e 's/^\(# ....-\)May/\105/' -e 's/^\(# ....-\)Nov/\111/'  \
    -e 's/^\(# ....-\)Jun/\106/' -e 's/^\(# ....-\)Dec/\112/'  \
    ChangeLog.tmp >ChangeLog
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
