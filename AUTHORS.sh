#
# This script generates an AUTHORS file by using git log. Just add this
# script to your repository, use it to generate your first AUTHORS file,
# add that to your repository, and repeat as needed.
#

set -e
git log --format='tformat:%an <%ae>' >AUTHORS.tmp
LC_ALL=C sort -u AUTHORS.tmp >AUTHORS
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
