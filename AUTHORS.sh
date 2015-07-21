#
# This script (AUTHORS.sh) creates an AUTHORS file for Autotools by
# using git log to retrieve the authors induced by HEAD. Just add this
# script to your repository, use it to create your first AUTHORS file,
# add that to your repository, and update it when making a commit that
# is intended to provide a distribution or git archive tarball.
#
# You can optionally add a file named AUTHORS.top, which will be
# included at the top of the AUTHORS file with a blank line following
# it. You can also write it in Texinfo by naming it AUTHORS.top.texi,
# which will be fed through makeinfo --plaintext before being included.
#
# Similarly, you can optionally add an AUTHORS.bot(.texi) file, which
# will be included at the bottom of the AUTHORS file with a blank line
# preceding it.
#

set -e
trap 'rm -f AUTHORS.tmp1 AUTHORS.tmp2' EXIT

#
# Process the AUTHORS.top(.texi) file.
#

if test -f AUTHORS.top; then
  cp AUTHORS.top AUTHORS.tmp1
  echo >>AUTHORS.tmp1
elif test -f AUTHORS.top.texi; then
  makeinfo --plaintext AUTHORS.top.texi >AUTHORS.tmp1
  echo >>AUTHORS.tmp1
else
  cp /dev/null AUTHORS.tmp1
fi

#
# Process the authors.
#

git log --author-date-order --pretty='%an <%ae>' --reverse >AUTHORS.tmp2
LC_ALL=C sort -u AUTHORS.tmp2 >>AUTHORS.tmp1

#
# Process the AUTHORS.bot(.texi) file.
#

if test -f AUTHORS.bot; then
  echo >>AUTHORS.tmp1
  cat AUTHORS.bot >>AUTHORS.tmp1
elif test -f AUTHORS.bot.texi; then
  makeinfo --plaintext AUTHORS.bot.texi >AUTHORS.tmp2
  echo >>AUTHORS.tmp1
  cat AUTHORS.tmp2 >>AUTHORS.tmp1
fi

#
# Finish up.
#

mv AUTHORS.tmp1 AUTHORS
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
