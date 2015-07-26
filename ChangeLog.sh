#
# This script (ChangeLog.sh) creates a ChangeLog file by using git log
# to get the reverse chronological list of commits reachable from HEAD.
#
# If the ChangeLog.top file exists, it will be added to the top of the
# ChangeLog file with a trailing blank line and lines starting with "#"
# removed. Otherwise, if the ChangeLog.top.texi file exists, it will be
# given to makeinfo --plaintext and added in the same way, but without
# line removal. This also occurs for the ChangeLog.bot(.texi) files, but
# adding to the bottom of the ChangeLog file with a leading blank line.
#
# If the ChangeLog.fix file exists, it will be used to sanitize names,
# email addresses, and commit subjects in the ChangeLog file. It must
# contain awk code that repeatedly calls the fix(ere, repl) function,
# which acts like the gsub function but applies to each name, email
# address, and commit subject. For example, the following code will
# replace each 0x01 and 0x02 byte with U+FFFD:
#
#   fix("\001", "\357\277\275")
#   fix("\002", "\357\277\275")
#

set -e
trap 'rm -f ChangeLog.tmp1 ChangeLog.tmp2 ChangeLog.tmp3' EXIT

if test -f ChangeLog.top; then
  sed '/^#/d' ChangeLog.top >ChangeLog.tmp1
  echo >>ChangeLog.tmp1
elif test -f ChangeLog.top.texi; then
  makeinfo --plaintext ChangeLog.top.texi >ChangeLog.tmp1
  echo >>ChangeLog.tmp1
else
  cp /dev/null ChangeLog.tmp1
fi

TZ=UTC git log --author-date-order --date=local \
               --pretty=%H%n%an%n%ae%n%ad%n%s >ChangeLog.tmp2

cat >ChangeLog.tmp3 <<'EOF'
  BEGIN {
    map["Jan"] = "01"; map["Feb"] = "02"; map["Mar"] = "03"
    map["Apr"] = "04"; map["May"] = "05"; map["Jun"] = "06"
    map["Jul"] = "07"; map["Aug"] = "08"; map["Sep"] = "09"
    map["Oct"] = "10"; map["Nov"] = "11"; map["Dec"] = "12"
  }
  NR % 5 == 1 {
    hash = $0
  }
  NR % 5 == 2 {
    name = $0
  }
  NR % 5 == 3 {
    email = $0
  }
  NR % 5 == 4 {
    year = $5
    month = map[$2]
    day = $3
    time = $4
  }
  NR % 5 == 0 {
    subject = $0
    apply_fixes()
    if (NR > 5) print ""
    print "commit " hash
    print "Author: " name " <" email ">"
    print "Date:   " year "-" month "-" day " " time " +0000"
    print ""
    print "    " subject
  }
  function fix(ere, repl) {
    gsub(ere, repl, name)
    gsub(ere, repl, email)
    gsub(ere, repl, subject)
  }
  function apply_fixes() {
EOF

if test -f ChangeLog.fix; then
  cat ChangeLog.fix >>ChangeLog.tmp3
fi

echo } >>ChangeLog.tmp3

LC_COLLATE=C LC_CTYPE=C awk -f ChangeLog.tmp3 \
                            ChangeLog.tmp2 >>ChangeLog.tmp1

if test -f ChangeLog.bot; then
  echo >>ChangeLog.tmp1
  sed '/^#/d' ChangeLog.bot >>ChangeLog.tmp1
elif test -f ChangeLog.bot.texi; then
  makeinfo --plaintext ChangeLog.bot.texi >ChangeLog.tmp2
  echo >>ChangeLog.tmp1
  cat ChangeLog.tmp2 >>ChangeLog.tmp1
fi

mv ChangeLog.tmp1 ChangeLog

#
# The authors of this file have waived all copyright and
# related or neighboring rights to the extent permitted by
# law as described by the CC0 1.0 Universal Public Domain
# Dedication. You should have received a copy of the full
# dedication along with this file, typically as a file
# named <CC0-1.0.txt>. If not, it may be available at
# <https://creativecommons.org/publicdomain/zero/1.0/>.
#
