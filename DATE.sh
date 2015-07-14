#
# This script (DATE.sh) helps to create a PACKAGE_DATE variable in
# configure.ac by using git log to retrieve the date of HEAD. Just add
# this script to your repository and adapt the following code for your
# configure.ac and Makefile.am:
#
#   m4_define([AC_PACKAGE_DATE], m4_esyscmd_s([sh DATE.sh]))
#   m4_assert(m4_sysval == 0)
#   PACKAGE_DATE=AC_PACKAGE_DATE
#   AC_SUBST([PACKAGE_DATE])
#   AC_DEFINE([PACKAGE_DATE], "AC_PACKAGE_DATE")
#
#   EXTRA_DIST = DATE.sh DATE
#
# When you run autoconf inside your repository, the script uses git log
# to print a YYYY-MM-DD date and also outputs it to the DATE file. When
# you run autoconf inside an extracted distribution tarball, the script
# uses the DATE file to print the date. If you also want autoconf to
# work inside an extracted git archive tarball, you can add the DATE
# file to your repository and update it as needed.
#

set -e
trap 'rm -f DATE.tmp' EXIT

#
# Try using git log.
#
# We want the author YYYY-MM-DD in UTC, but the only git log author date
# format that respects TZ=UTC is %ad. So we hopefully improve the chance
# that it's in standard C form with LC_ALL=C and convert it like this:
#
#      Wed Jul 1 12:34:56 2015
#   -> 2015-Jul-1
#   -> 2015-07-1
#   -> 2015-07-01
#

set +e
x=$(LC_ALL=C TZ=UTC git log -1 --date=local --pretty=%ad 2>/dev/null)
y="$?"
set -e
if test "$y" = 0; then
  echo "$x" >DATE.tmp
  x=$(sed '/^... ... ..* ..:..:.. ....$/ {
             s/^... \(...\) \(..*\) ..:..:.. \(....\)$/\3-\1-\2/
             s/^\(....\)-Jan/\1-01/
             s/^\(....\)-Feb/\1-02/
             s/^\(....\)-Mar/\1-03/
             s/^\(....\)-Apr/\1-04/
             s/^\(....\)-May/\1-05/
             s/^\(....\)-Jun/\1-06/
             s/^\(....\)-Jul/\1-07/
             s/^\(....\)-Aug/\1-08/
             s/^\(....\)-Sep/\1-09/
             s/^\(....\)-Oct/\1-10/
             s/^\(....\)-Nov/\1-11/
             s/^\(....\)-Dec/\1-12/
             s/^\(....-..\)-\(.\)$/\1-0\2/
           }' DATE.tmp)
  echo "$x" >DATE.tmp
  mv DATE.tmp DATE
  echo "$x"
  exit 0
fi

#
# If that didn't work, try using the DATE file.
#

if test -f DATE; then
  cat DATE
  exit 0
fi

#
# If that didn't work, something is wrong.
#

echo 'DATE.sh: git log failed and DATE does not exist' >&2
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
