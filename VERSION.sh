#
# This script (VERSION.sh) helps to create a version string for AC_INIT
# in configure.ac by using git describe to create a version string for
# HEAD. Just add this script to your repository and adapt the following
# code for your configure.ac and Makefile.am files:
#
#   AC_INIT([foo], m4_esyscmd_s([sh VERSION.sh]))
#
#   EXTRA_DIST += VERSION.sh VERSION
#
# This makes Autotools work both inside your repository and inside an
# extracted distribution tarball. When running inside your repository,
# VERSION.sh uses git describe to create a version string for HEAD and
# also writes it to the VERSION file. When running inside an extracted
# distribution tarball, VERSION.sh reads the VERSION file instead of
# using git describe.
#
# To also make Autotools work inside an extracted git archive tarball,
# add the VERSION file to your repository and update it when making a
# commit that is intended to be used with git archive.
#
# This script assumes that you tag your version commits with names that
# begin with "v" and a digit, like "v2.63" or "v2.5.0-rc0".
#

set -e
trap 'rm -f VERSION.tmp' EXIT

#
# Try using git describe.
#

set +e
x=$(git describe --always --match='v[0-9]*' --tags 2>/dev/null)
y="$?"
set -e
if test "$y" = 0; then
  echo "$x" >VERSION.tmp
  x=$(sed 's/^v//' VERSION.tmp)
  echo "$x" >VERSION.tmp
  mv VERSION.tmp VERSION
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
