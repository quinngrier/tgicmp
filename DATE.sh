#
# This script (DATE.sh) helps to create a PACKAGE_DATE variable in
# configure.ac by using git log to retrieve the date of HEAD. Just add
# this script to your repository and adapt the following code for your
# configure.ac and Makefile.am files:
#
#   m4_define([AC_PACKAGE_DATE], m4_esyscmd_s([sh DATE.sh]))
#   m4_assert(m4_sysval == 0)
#   PACKAGE_DATE=AC_PACKAGE_DATE
#   AC_SUBST([PACKAGE_DATE])
#   AC_DEFINE([PACKAGE_DATE], "AC_PACKAGE_DATE")
#
#   EXTRA_DIST += DATE.sh DATE
#
# This makes Autotools work both inside your repository and inside an
# extracted distribution tarball. When running inside your repository,
# DATE.sh uses git log to retrieve the date of HEAD and also writes it
# to the DATE file. When running inside an extracted distribution
# tarball, DATE.sh reads the DATE file instead of using git log.
#
# To also make Autotools work inside an extracted git archive tarball,
# add the DATE file to your repository and update it when making a
# commit that is intended to be used with git archive.
#

set -e
trap 'rm -f DATE.tmp' EXIT

#
# First we need to check if we're running inside your repository. We
# can't just consider any successful git command to mean that this is
# true because we might be running inside an extracted tarball that's
# inside another repository. The trick is to test if this script file
# itself is being tracked by the repository.
#

if git ls-files --error-unmatch DATE.sh >/dev/null 2>&1; then

  #
  # We want the author date of HEAD in YYYY-MM-DD UTC form, but it
  # appears that git log only respects TZ=UTC when it is invoked with
  # --date=local --pretty=%ad. This format is the same as the format of
  # the asctime function except that single-digit day numbers have only
  # one preceding space instead of two. We convert this format to our
  # desired format as follows:
  #
  #      Wed Jul 1 12:34:56 2015
  #   -> 2015-Jul-1
  #   -> 2015-07-1
  #   -> 2015-07-01
  #

  TZ=UTC git log -1 --date=local --pretty=%ad >DATE.tmp
  x=$(sed 's/... \(...\) \(.\{1,2\}\) ..:..:.. \(....\)/\3-\1-\2/
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
           s/-\(.\)$/-0\1/' DATE.tmp)
  echo "$x" >DATE.tmp
  mv DATE.tmp DATE
  echo "$x"
  exit 0

fi

#
# If we get here, then we're not running inside your repository, so we
# try to read the DATE file.
#

if test -f DATE; then
  cat DATE
  exit 0
fi

#
# If we get here, then we're not running inside your repository and we
# couldn't read the DATE file, so we give up.
#

echo 'DATE.sh: not in repository and DATE not found' >&2
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
