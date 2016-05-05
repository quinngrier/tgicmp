#ifndef TGICMPLT
  #define TGICMPLT(x, y) \
    ((x) % 1 == 0 && /* allow only integers */ \
     (y) % 1 == 0 && /* allow only integers */ \
     (((x) < 0) == ((y) < 0) ? (x) < (y) : (x) < 0))
#endif

#ifndef TGICMPGT
  #define TGICMPGT(x, y) TGICMPLT(y, x)
#endif

#ifndef TGICMPLE
  #define TGICMPLE(x, y) (!TGICMPGT(x, y))
#endif

#ifndef TGICMPGE
  #define TGICMPGE(x, y) (!TGICMPLT(x, y))
#endif

#ifndef TGICMPEQ
  #define TGICMPEQ(x, y) (TGICMPLE(x, y) && TGICMPGE(x, y))
#endif

#ifndef TGICMPNE
  #define TGICMPNE(x, y) (!TGICMPEQ(x, y))
#endif

/*
 * The authors of this file have waived all copyright and
 * related or neighboring rights to the extent permitted by
 * law as described by the CC0 1.0 Universal Public Domain
 * Dedication. You should have received a copy of the full
 * dedication along with this file, typically as a file
 * named <CC0-1.0.txt>. If not, it may be available at
 * <https://creativecommons.org/publicdomain/zero/1.0/>.
 */
