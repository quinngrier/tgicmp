#include <wficmp.h>

#if (!defined(TGICMPEQ))
  #define TGICMPEQ(x, y) ( \
    (x) % 1 == 0 /* allow only integers */ \
    && \
    (y) % 1 == 0 /* allow only integers */ \
    && \
    ( \
      WFICMPLT(x, 0) == WFICMPLT(y, 0) ? \
      WFICMPEQ(x, y) : \
      0 \
    ) \
  )
#endif

#if (!defined(TGICMPGE))
  #define TGICMPGE(x, y) ( \
    (x) % 1 == 0 /* allow only integers */ \
    && \
    (y) % 1 == 0 /* allow only integers */ \
    && \
    ( \
      WFICMPLT(x, 0) == WFICMPLT(y, 0) ? \
      WFICMPGE(x, y) : \
      WFICMPLT(y, 0) \
    ) \
  )
#endif

#if (!defined(TGICMPGT))
  #define TGICMPGT(x, y) ( \
    (x) % 1 == 0 /* allow only integers */ \
    && \
    (y) % 1 == 0 /* allow only integers */ \
    && \
    ( \
      WFICMPLT(x, 0) == WFICMPLT(y, 0) ? \
      WFICMPGT(x, y) : \
      WFICMPLT(y, 0) \
    ) \
  )
#endif

#if (!defined(TGICMPLE))
  #define TGICMPLE(x, y) ( \
    (x) % 1 == 0 /* allow only integers */ \
    && \
    (y) % 1 == 0 /* allow only integers */ \
    && \
    ( \
      WFICMPLT(x, 0) == WFICMPLT(y, 0) ? \
      WFICMPLE(x, y) : \
      WFICMPLT(x, 0) \
    ) \
  )
#endif

#if (!defined(TGICMPLT))
  #define TGICMPLT(x, y) ( \
    (x) % 1 == 0 /* allow only integers */ \
    && \
    (y) % 1 == 0 /* allow only integers */ \
    && \
    ( \
      WFICMPLT(x, 0) == WFICMPLT(y, 0) ? \
      WFICMPLT(x, y) : \
      WFICMPLT(x, 0) \
    ) \
  )
#endif

#if (!defined(TGICMPNE))
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
