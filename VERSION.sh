#
# This script helps autoconf automatically generate a version string for
# AC_INIT by using git describe. Just add this script to your repository
# and merge the following code into your configure.ac and Makefile.am:
#
#   AC_INIT([foo], m4_esyscmd_s([sh VERSION.sh]))
#
#   EXTRA_DIST = VERSION.sh VERSION
#
# The script assumes that you tag your version commits with strings that
# begin with "v" and a digit, like "v2.63" or "v2.5.0-rc0". When you run
# autoconf inside your repository, the script uses git describe to print
# a version string and also outputs it to the VERSION file. When you run
# autoconf inside an extracted distribution tarball, the script uses the
# VERSION file to print the version string. If you also want autoconf to
# work inside an extracted git archive tarball, you can add the VERSION
# file to your repository and update it as needed.
#

set -e

#
# Try using git describe.
#

set +e
x=$(git describe --always --match='v[0-9]*' --tags 2>/dev/null)
y="$?"
set -e
if test "$y" = 0; then
  echo "$x" >VERSION
  x=$(sed 's/^v//' VERSION)
  echo "$x" >VERSION
  echo "$x"
  exit 0
fi

#
# If that didn't work, try using the VERSION file.
#

if test -f VERSION; then
  cat VERSION
  exit 0
fi

#
# If that didn't work, something is wrong. autoconf doesn't care about
# our exit status, but as long as we don't print anything then it will
# get mad about an empty version string.
#

echo 'VERSION.sh: git describe failed and VERSION does not exist' >&2
exit 1

#
# The authors of this file have waived all copyright and
# related or neighboring rights to the extent permitted by
# law as described by the CC0 1.0 Universal Public Domain
# Dedication. You should have received a copy of the full
# dedication along with this file, typically as a file
# named <CC0-1.0.txt>. If not, it may be available at
# <https://creativecommons.org/publicdomain/zero/1.0/>.
#
