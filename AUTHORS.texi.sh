#
# This script (AUTHORS.texi.sh) creates an AUTHORS.texi file for use in
# a Texinfo manual by using git log to retrieve the authors induced by
# HEAD. Just add this script to your repository, use it to create your
# first AUTHORS.texi file, add that to your repository, and update it
# when making a commit that is intended to provide a distribution
# tarball or git archive tarball.
#
# You can optionally add a file named AUTHORS.texi.top, which will be
# included at the top of the AUTHORS.texi file with a blank line
# following it.
#

set -e
trap 'for i in 1 2 3; do rm -f AUTHORS.texi.tmp$i; done' EXIT

#
# Process AUTHORS.texi.top into AUTHORS.texi.tmp1. This is the file that
# we'll be accumulating into and eventually renaming to AUTHORS.texi.
#

if test -f AUTHORS.texi.top; then
  cp AUTHORS.texi.top AUTHORS.texi.tmp1
  echo >>AUTHORS.texi.tmp1
else
  cp /dev/null AUTHORS.texi.tmp1
fi

exit 0

#
# The authors of this file have waived all copyright and
# related or neighboring rights to the extent permitted by
# law as described by the CC0 1.0 Universal Public Domain
# Dedication. You should have received a copy of the full
# dedication along with this file, typically as a file
# named <CC0-1.0.txt>. If not, it may be available at
# <https://creativecommons.org/publicdomain/zero/1.0/>.
#
