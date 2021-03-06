#
# This script (AUTHORS.texi.sh) creates an AUTHORS.texi file by using
# git log --author-date-order to list the authors reachable from HEAD.
#
# If the AUTHORS.texi.top file exists, it will be added to the top of
# the AUTHORS.texi file with lines starting with "#" removed. This also
# occurs for the AUTHORS.texi.bot file, but adding to the bottom of the
# AUTHORS.texi file.
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
  LC_COLLATE=C LC_CTYPE=C \
    sed '/^#/d' AUTHORS.texi.top >AUTHORS.texi.tmp1
else
  cp /dev/null AUTHORS.texi.tmp1
fi

TZ=UTC git log --author-date-order --date=local \
               --pretty=%aN%n%aE%n%ad --reverse >AUTHORS.texi.tmp2

cat >AUTHORS.texi.tmp3 <<'EOF'
  BEGIN { print "@table @asis" }
  NR % 3 == 1 { name = $0 }
  NR % 3 == 2 { email = $0 }
  NR % 3 == 0 {
    year = $5
    pair = name "\n" email
    if (map[pair]) {
      i = map[pair]
      if (year < minyears[i]) minyears[i] = year
      if (year > maxyears[i]) maxyears[i] = year
    } else {
      i = map[pair] = ++n
      apply_fix_file()
      fix("@", "@@")
      fix("\\{", "@{")
      fix("}", "@}")
      names[i] = name
      emails[i] = email
      minyears[i] = year
      maxyears[i] = year
    }
    years[i, year] = 1
    ++count[i]
    ++total
  }
  END {
    for (i = 1; i <= n; ++i) {
      if (i > 1) print ""
      print "@frenchspacing on"
      print "@item " names[i] " --- @email{" emails[i] "}"
      print "@frenchspacing off"
      printf "%d commit%s", count[i], (count[i] > 1 ? "s" : "")
      printf " (%.2f%%)", count[i] / total * 100
      printf " in %d", minyears[i]
      for (y = minyears[i] + 1; y <= maxyears[i]; ++y)
        if (!years[i, y]) continue
        else if (!years[i, y - 1]) printf ", %d", y
        else if (!years[i, y + 1]) printf "--%d", y
      print "."
    }
    print "@end table"
  }
  function fix(ere, repl) {
    gsub(ere, repl, name)
    gsub(ere, repl, email)
  }
  function apply_fix_file() {
EOF

if test -f AUTHORS.texi.fix; then
  cat AUTHORS.texi.fix >>AUTHORS.texi.tmp3
fi

echo } >>AUTHORS.texi.tmp3

LC_COLLATE=C LC_CTYPE=C LC_NUMERIC=C \
  awk -f AUTHORS.texi.tmp3 AUTHORS.texi.tmp2 >>AUTHORS.texi.tmp1

if test -f AUTHORS.texi.bot; then
  LC_COLLATE=C LC_CTYPE=C \
    sed '/^#/d' AUTHORS.texi.bot >>AUTHORS.texi.tmp1
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
