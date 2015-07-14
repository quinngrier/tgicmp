#
# This script helps autoconf make a PACKAGE_DATE variable by using git
# log. Just add this script to your repository and merge the following
# code into your configure.ac and Makefile.am:
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
# that it's in standard C form with LC_ALL=C and do some parsing.
#
# Here is an example of how the parsing works:
#
#      Wed Jul 1 12:34:56 2015
#   -> 2015-Jul-1
#   -> 2015-Jul-01
#   -> 2015-07-01
#

set +e
x=$(LC_ALL=C TZ=UTC \
    git log -1 --date=local --format='tformat:%ad' 2>/dev/null)
y="$?"
set -e
if test "$y" = 0; then
  echo "$x" >DATE.tmp
  x=$(sed -e 's/^... \(...\) \([^ ]*\).\{10\}\(....\)/\3-\1-\2/' \
          -e 's/^\(....-...-\)\(.\)$/\10\2/'                     \
          -e 's/^\(....-\)Jan/\101/' -e 's/^\(....-\)Jul/\107/'  \
          -e 's/^\(....-\)Feb/\102/' -e 's/^\(....-\)Aug/\108/'  \
          -e 's/^\(....-\)Mar/\103/' -e 's/^\(....-\)Sep/\109/'  \
          -e 's/^\(....-\)Apr/\104/' -e 's/^\(....-\)Oct/\110/'  \
          -e 's/^\(....-\)May/\105/' -e 's/^\(....-\)Nov/\111/'  \
          -e 's/^\(....-\)Jun/\106/' -e 's/^\(....-\)Dec/\112/'  \
          DATE.tmp)
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
