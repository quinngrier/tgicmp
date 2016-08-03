#
# This file was generated by GATBPS 0.0.0-2490-g29c3a1e, which was
# released on 2016-05-03. Before changing it, make sure
# you're doing the right thing. Depending on how GATBPS
# is being used, your changes may be automatically lost.
# A short description of this file follows.
#
# Special file: VERSION.sh
#
# For more information, see the GATBPS manual.
#

#
# This script (VERSION.sh) helps to create a version string for
# Autotools by using git describe to get the description of HEAD with
# respect to tags that begin with "v" and a digit. Add this script to
# your repository and adjust the following code for your configure.ac
# and Makefile.am files:
#
#   AC_INIT([Example],
#           m4_esyscmd_s([sh VERSION.sh])m4_assert(m4_sysval == 0))
#
#   EXTRA_DIST += $(srcdir)/VERSION
#   EXTRA_DIST += $(srcdir)/VERSION.sh
#
# When running in your repository, the script uses git describe.
# Elsewhere, the script reads the
# VERSION file.
#

#
# With LC_ALL=C, locale-aware programs use the C locale instead of the
# current locale. This is generally the best approach for code that is
# not deliberately designed to work in other locales. The C locale has
# predictable behavior and is compatible with UTF-8. Other locales may
# have surprising behavior. This affects many important programs, like
# awk, grep, sed, and this shell instance itself. For more information,
# see the C standard, the POSIX standard, and the GNU C Library manual.
#

LC_ALL='C'
export 'LC_ALL'

set -e
trap 'rm -f VERSION.tmp' EXIT
if git ls-files --error-unmatch "${0}" >/dev/null 2>&1; then
  git describe --always --match='v[0-9]*' --tags >VERSION.tmp
  x=$(sed s/^v// VERSION.tmp)
  echo "$x"
elif test -f VERSION; then
  cat VERSION
else
  echo 'VERSION.sh: not in repository and VERSION not found' >&2
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