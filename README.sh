#
# This script (README.sh) creates a README file from the README.texi
# file by using makeinfo --plaintext.
#

set -e
trap 'rm -f README.tmp' EXIT
makeinfo --plaintext README.texi >README.tmp
mv README.tmp README
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
