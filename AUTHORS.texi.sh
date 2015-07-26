#
# This script (AUTHORS.texi.sh) creates an AUTHORS.texi file by using
# git log to get the chronological list of authors reachable from HEAD.
#
# If the AUTHORS.texi.top file exists, it will be added to the top of
# the AUTHORS.texi file. If the AUTHORS.texi.bot file exists, it will be
# added to the bottom of the AUTHORS.texi file.
#
# If the AUTHORS.texi.fix file exists, it will be used to sanitize names
# and email addresses in the AUTHORS.texi file. It must contain awk code
# that repeatedly calls the fix(ere, repl) function, which acts like the
# gsub function but applies to each name and email address. For example,
# the following code will replace each 0x01 and 0x02 byte with U+FFFD:
#
#   fix("\001", "\357\277\275")
#   fix("\002", "\357\277\275")
#

set -e
trap 'rm -f AUTHORS.texi.tmp1 AUTHORS.texi.tmp2 AUTHORS.texi.tmp3' EXIT

if test -f AUTHORS.texi.top; then
  cp AUTHORS.texi.top AUTHORS.texi.tmp1
else
  cp /dev/null AUTHORS.texi.tmp1
fi

TZ=UTC git log --author-date-order --date=local \
               --pretty=%an%n%ae%n%ad --reverse >AUTHORS.texi.tmp2

cat >AUTHORS.texi.tmp3 <<'EOF'
  BEGIN {
    print "@table @asis"
  }
  NR % 3 == 1 { name = $0 }
  NR % 3 == 2 { email = $0 }
  NR % 3 == 0 {
    year = $5
    pair = name "\n" email
    if (map[pair]) {
      i = map[pair]
      if (year < min_years[i]) min_years[i] = year
      if (year > max_years[i]) max_years[i] = year
    } else {
      i = map[pair] = ++n
      apply_fixes()
      names[i] = name
      emails[i] = email
      min_years[i] = year
      max_years[i] = year
    }
    years[i, year] = 1
  }
  END {
    print "@end table"
  }
  function fix(ere, repl) {
    gsub(ere, repl, name)
    gsub(ere, repl, email)
  }
  function apply_fixes() {
EOF

if test -f AUTHORS.texi.fix; then
  cat AUTHORS.texi.fix >>AUTHORS.texi.tmp3
fi

echo } >>AUTHORS.texi.tmp3

LC_COLLATE=C LC_CTYPE=C \
  awk -f AUTHORS.texi.tmp3 AUTHORS.texi.tmp2 >>AUTHORS.texi.tmp1

if test -f AUTHORS.texi.bot; then
  cat AUTHORS.texi.bot >>AUTHORS.texi.tmp1
fi

mv AUTHORS.texi.tmp1 AUTHORS.texi

#
# The authors of this file have waived all copyright and
# related or neighboring rights to the extent permitted by
# law as described by the CC0 1.0 Universal Public Domain
# Dedication. You should have received a copy of the full
# dedication along with this file, typically as a file
# named <CC0-1.0.txt>. If not, it may be available at
# <https://creativecommons.org/publicdomain/zero/1.0/>.
#
