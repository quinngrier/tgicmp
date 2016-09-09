AC_INIT(
  [[TGICMP]],
  m4_esyscmd_s([
    'sh' '-' 'build-aux/VERSION.sh'
  ])m4_if(m4_sysval, [0], [], [m4_fatal([VERSION.sh failed])]),
  [[quinn.grier@gmail.com]],
  [[tgicmp]],
  [[https://www.quinngrier.com/tgicmp]])[

]GATBPS_DEFINE_DATE(
  [AC_],
  [PACKAGE_DATE],
  m4_esyscmd_s([
    'sh' '-' 'build-aux/DATE.sh'
  ])m4_if(m4_sysval, [0], [], [m4_fatal([DATE.sh failed])]))[

]m4_include([build-aux/CC0-1.0-AC-COPYRIGHT.ac])[

]AC_CONFIG_AUX_DIR([build-aux])[
]AC_CONFIG_MACRO_DIR([m4])[
]AC_CONFIG_MACRO_DIRS([m4])[
]AC_CONFIG_SRCDIR([doc/tgicmp.texi])[

]AM_INIT_AUTOMAKE([
  -Wall
  foreign
  nostdinc
  subdir-objects
  tar-ustar
])

AT='@'
AC_SUBST([AT])

AC_SUBST([TEXI2DVIFLAGS])

AC_CONFIG_FILES([Makefile])

GATBPS_CONFIG_FILE_SUBST

AC_OUTPUT

dnl
dnl The authors of this file have waived all copyright and
dnl related or neighboring rights to the extent permitted by
dnl law as described by the CC0 1.0 Universal Public Domain
dnl Dedication. You should have received a copy of the full
dnl dedication along with this file, typically as a file
dnl named <CC0-1.0.txt>. If not, it may be available at
dnl <https://creativecommons.org/publicdomain/zero/1.0/>.
dnl
