#include "tgicmp.h"
#include "tgicmp.h"
#undef NDEBUG
#include <assert.h>
int
main(
  void
) {
  int const x1 = -1;
  unsigned int const y1 = 0;
  assert(TGILT(x1, y1) == 1);
  return 0;
}

/*
 * The authors of this file have waived all copyright and
 * related or neighboring rights to the extent permitted by
 * law as described by the CC0 1.0 Universal Public Domain
 * Dedication. You should have received a copy of the full
 * dedication along with this file, typically as a file
 * named <CC0-1.0.txt>. If not, it may be available at
 * <https://creativecommons.org/publicdomain/zero/1.0/>.
 */
