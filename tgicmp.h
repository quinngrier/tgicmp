#ifndef TGIGE
#define TGIGE(x, y) \
  ((x) % 1 == 0 && \
   (y) % 1 == 0 && \
   ((((x) > 0 || (x) == 0) && ((y) > 0 || (y) == 0)) || \
    (((x) <= 0 && (x) != 0) && ((y) <= 0 && (y) != 0)) ? \
    (x) + ((y) - (y)) >= (y) + ((x) - (x)) : (x) > 0 || (x) == 0))
#endif

#ifndef TGIGT
#define TGIGT(x, y) \
  ((x) % 1 == 0 && \
   (y) % 1 == 0 && \
   ((((x) > 0 || (x) == 0) && ((y) > 0 || (y) == 0)) || \
    (((x) <= 0 && (x) != 0) && ((y) <= 0 && (y) != 0)) ? \
    (x) + ((y) - (y)) > (y) + ((x) - (x)) : (x) > 0 || (x) == 0))
#endif

#ifndef TGILE
#define TGILE(x, y) (!TGIGT(x, y))
#endif

#ifndef TGILT
#define TGILT(x, y) (!TGIGE(x, y))
#endif

#ifndef TGIEQ
#define TGIEQ(x, y) (TGIGE(x, y) && TGILE(x, y))
#endif

#ifndef TGINE
#define TGINE(x, y) (!TGIEQ(x, y))
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
