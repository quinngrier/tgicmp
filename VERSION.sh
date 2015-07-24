#
# This script (VERSION.sh) helps to create a version string for
# Autotools by using git describe to get the description of HEAD with
# respect to tags that begin with "v" and a digit. Add this script to
# your repository and adjust the following code for your configure.ac
# and Makefile.am:
#
#   AC_INIT([foo], m4_esyscmd_s([sh VERSION.sh]))
#
#   EXTRA_DIST += VERSION.sh VERSION
#
# When running in your repository, the script uses git describe and also
# writes the result to the VERSION file. Elsewhere, the script reads the
# VERSION file. Add the VERSION file to your repository to make git
# archive tarballs work.
#

set -e
trap 'rm -f VERSION.tmp' EXIT

#
# If we're in your repository, then this script itself is tracked.
# The converse is not necessarily true, but it's the best we can do.
#

if git ls-files --error-unmatch VERSION.sh >/dev/null 2>&1; then
  # Remove the "v" to follow the usual style.
  git describe --always --match='v[0-9]*' --tags >VERSION.tmp
  x=$(sed s/^v// VERSION.tmp)
  echo "$x" >VERSION.tmp
  mv VERSION.tmp VERSION
  echo "$x"
  exit 0
fi

if test -f VERSION; then
  cat VERSION
  exit 0
fi

#
# If we get here, then we're not running inside the repository and we
# couldn't read the VERSION file, so we give up. autoconf doesn't care
# about our exit code, but as long as we don't print anything then it
# will get mad about being given an empty version string. It would
# probably not be wise to try to check m4_sysval, as AC_INIT might
# overwrite it by running other commands.
#

echo 'VERSION.sh: not in repository and VERSION not found' >&2
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
