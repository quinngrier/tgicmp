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
# This makes Autotools work both inside your repository and inside an
# extracted distribution tarball. When running inside your repository,
# VERSION.sh uses git describe to create a version string for HEAD and
# also writes it to the VERSION file. When running inside an extracted
# distribution tarball, VERSION.sh reads the VERSION file instead of
# using git describe.
#
# To also make Autotools work inside an extracted git archive tarball,
# add the VERSION file to your repository and update it when making a
# commit that is intended to provide a git archive tarball.
#

set -e
trap 'rm -f VERSION.tmp' EXIT

#
# First we need to check if we're running inside the repository. We
# can't just consider any successful git command to mean that this is
# true because we might be running inside an extracted tarball that's
# inside another repository. The trick is to test if this script file
# itself is being tracked by the repository.
#

if git ls-files --error-unmatch VERSION.sh >/dev/null 2>&1; then

  #
  # We want the result of git describe when looking for a tag whose name
  # begins with "v" and a digit, like "v1.23" or "v1.2.3-rc4". This will
  # give a result like "v1.23" when HEAD is the same as the tag, or like
  # "v1.23-456-g789abcd" when HEAD is newer than the tag. We then remove
  # the leading "v" to follow the usual Autotools style.
  #

  git describe --always --match='v[0-9]*' --tags >VERSION.tmp
  x=$(sed s/^v// VERSION.tmp)
  echo "$x" >VERSION.tmp
  mv VERSION.tmp VERSION
  echo "$x"
  exit 0

fi

#
# If we get here, then we're not running inside the repository, so we
# try to read the VERSION file.
#

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
