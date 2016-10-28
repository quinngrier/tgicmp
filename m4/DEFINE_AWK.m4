AC_DEFUN([DEFINE_AWK], [[{

#
# The block that contains this comment is the expansion of the
# DEFINE_AWK macro.
#]dnl
m4_ifdef(
  [DEFINE_AWK_HAS_BEEN_CALLED],
  [gatbps_fatal([
    DEFINE_AWK has already been called
  ])],
  [m4_define([DEFINE_AWK_HAS_BEEN_CALLED])])[]dnl
m4_if(
  m4_eval([$# < 0 || $# > 0]),
  [1],
  [gatbps_fatal([
    DEFINE_AWK requires exactly 0 arguments
    ($# ]m4_if([$#], [1], [[was]], [[were]])[ given)
  ])])[]dnl
[

]AC_REQUIRE([GATBPS_PROG_AWK])[

:;}]])[]dnl
dnl
dnl The authors of this file have waived all copyright and
dnl related or neighboring rights to the extent permitted by
dnl law as described by the CC0 1.0 Universal Public Domain
dnl Dedication. You should have received a copy of the full
dnl dedication along with this file, typically as a file
dnl named <CC0-1.0.txt>. If not, it may be available at
dnl <https://creativecommons.org/publicdomain/zero/1.0/>.
dnl
