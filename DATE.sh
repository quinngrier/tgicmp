#
# This script (DATE.sh) helps to create an (AC_)PACKAGE_DATE variable
# for Autotools by using git log to get the UTC author date of HEAD in
# YYYY-MM-DD format. Add this script to your repository and adjust the
# following code for your configure.ac and Makefile.am files:
#
#   m4_define([AC_PACKAGE_DATE],
#             m4_esyscmd_s([sh DATE.sh])m4_assert(!m4_sysval))
#   PACKAGE_DATE=AC_PACKAGE_DATE
#   AC_SUBST([PACKAGE_DATE])
#   AC_DEFINE([PACKAGE_DATE], "AC_PACKAGE_DATE")
#
#   EXTRA_DIST += DATE.sh DATE
#
# When running in your repository, the script uses git log and also
# writes the result to the DATE file. Elsewhere, the script reads the
# DATE file.
#

set -e
trap 'rm -f DATE.tmp' EXIT
if git ls-files --error-unmatch DATE.sh >/dev/null 2>&1; then
  TZ=UTC git log -1 --date=local --pretty=%ad >DATE.tmp
  x=$(sed 's/... \(...\) \(.*\) ..:..:.. \(....\)/\3-\1-\2/
           s/Jan/01/; s/Feb/02/; s/Mar/03/; s/Apr/04/
           s/May/05/; s/Jun/06/; s/Jul/07/; s/Aug/08/
           s/Sep/09/; s/Oct/10/; s/Nov/11/; s/Dec/12/
           s/-\(.\)$/-0\1/' DATE.tmp)
  echo "$x" >DATE.tmp
  mv DATE.tmp DATE
  echo "$x"
elif test -f DATE; then
  cat DATE
else
  echo 'DATE.sh: not in repository and DATE not found' >&2
  exit 1
fi

#
# The authors of this file have waived all copyright and
# related or neighboring rights to the extent permitted by
# law as described by the CC0 1.0 Universal Public Domain
# Dedication. You should have received a copy of the full
# dedication along with this file, typically as a file
# named <CC0-1.0.txt>. If not, it may be available at
# <https://creativecommons.org/publicdomain/zero/1.0/>.
#
