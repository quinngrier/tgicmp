#
# This script makes autoconf automatically generate a version string for
# AC_INIT by using git describe. Just add this script to your repository
# and use AC_INIT (in configure.ac) and EXTRA_DIST (in Makefile.am) like
# this:
#
#   AC_INIT([foo], [m4_esyscmd_s([sh VERSION.sh])])
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
# file to your repository and update it at your leisure.
#

set -e

# Try running git describe.
set +e
x=$(git describe --always --dirty --match='v[0-9]*' --tags)
y="$?"
set -e
if test "$y" = 0; then
  echo "$x" >VERSION
  x=$(sed s/^v// VERSION)
  echo "$x" >VERSION
  echo "$x"
  exit 0
fi

# If that didn't work, try reading VERSION.
if test -f VERSION; then
  cat VERSION
  exit 0
fi

# If that didn't work, something is wrong. The m4_esyscmd_s call that's
# running us doesn't care about our exit code, but as long as we refuse
# to print anything, then autoconf will at least get mad about an empty
# version string.
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
