all:

## begin_variables

GATBPS = 'gatbps'

GATBPSFLAGS =

GENERATE = $(GATBPS) $(GATBPSFLAGS) '--'

MKDIR_P = 'mkdir' '-p'

files = \
  CC0-1.0.txt \
  build-aux/CC0-1.0-AC-COPYRIGHT.ac \
  build-aux/CC0-1.0-AM-COPYRIGHT.am \
  build-aux/DATE.sh \
  build-aux/GATBPS_CONFIG_FILE_RULES.am \
  build-aux/GATBPS_RECIPE_MARKER.am \
  build-aux/GATBPS_V_PAD.am \
  build-aux/VERSION.sh \
  build-aux/doxygen.am \
  build-aux/echo.sh \
  dev-aux/CC0-1.0-commit.txt \
  dev-aux/format.ac.vim \
  dev-aux/format.am.vim \
  m4/GATBPS_CONFIG_FILE.m4 \
  m4/GATBPS_CONFIG_FILE_SUBST.m4 \
  m4/GATBPS_DEFINE_AT.m4 \
  m4/GATBPS_DEFINE_DATE.m4 \
  m4/GATBPS_MSG_ERROR.m4 \
  m4/GATBPS_MSG_NOTICE.m4 \
  m4/GATBPS_PROG_AWK.m4 \
  m4/GATBPS_PROG_DOXYGEN.m4 \
  m4/gatbps_fatal.m4 \
  m4/gatbps_notice.m4

## end_variables

## begin_rules

$(files):
	@$(MKDIR_P) './'$(@D)
	$(GENERATE) './'$@

.PHONY: $(files)
.PHONY: all

all: $(files)

## end_rules

#
# The authors of this file have waived all copyright and
# related or neighboring rights to the extent permitted by
# law as described by the CC0 1.0 Universal Public Domain
# Dedication. You should have received a copy of the full
# dedication along with this file, typically as a file
# named <CC0-1.0.txt>. If not, it may be available at
# <https://creativecommons.org/publicdomain/zero/1.0/>.
#
