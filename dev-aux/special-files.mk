all:

## begin_variables

GATBPS = 'gatbps'

GATBPSFLAGS =

GENERATE = $(GATBPS) $(GATBPSFLAGS) '--'

## end_variables

## begin_rules

.PHONY: CC0-1.0.txt
.PHONY: all
.PHONY: build-aux/CC0-1.0-AC-COPYRIGHT.ac
.PHONY: build-aux/CC0-1.0-AM-COPYRIGHT.am
.PHONY: build-aux/DATE.sh
.PHONY: build-aux/GATBPS_CONFIG_FILE_RULES.am
.PHONY: build-aux/GATBPS_RECIPE_MARKER.am
.PHONY: build-aux/GATBPS_V_PAD.am
.PHONY: build-aux/VERSION.sh
.PHONY: build-aux/doxygen.am
.PHONY: build-aux/echo.sh
.PHONY: dev-aux/CC0-1.0-commit.txt
.PHONY: dev-aux/format.ac.vim
.PHONY: dev-aux/format.am.vim
.PHONY: m4/GATBPS_CONFIG_FILE.m4
.PHONY: m4/GATBPS_CONFIG_FILE_SUBST.m4
.PHONY: m4/GATBPS_DEFINE_AT.m4
.PHONY: m4/GATBPS_DEFINE_DATE.m4
.PHONY: m4/GATBPS_MSG_NOTICE.m4
.PHONY: m4/GATBPS_PROG_AWK.m4
.PHONY: m4/GATBPS_PROG_DOXYGEN.m4
.PHONY: m4/gatbps_fatal.m4
.PHONY: m4/gatbps_notice.m4

CC0-1.0.txt:
	$(GENERATE) $@

all: CC0-1.0.txt
all: build-aux/CC0-1.0-AC-COPYRIGHT.ac
all: build-aux/CC0-1.0-AM-COPYRIGHT.am
all: build-aux/DATE.sh
all: build-aux/GATBPS_CONFIG_FILE_RULES.am
all: build-aux/GATBPS_RECIPE_MARKER.am
all: build-aux/GATBPS_V_PAD.am
all: build-aux/VERSION.sh
all: build-aux/doxygen.am
all: build-aux/echo.sh
all: dev-aux/CC0-1.0-commit.txt
all: dev-aux/format.ac.vim
all: dev-aux/format.am.vim
all: m4/GATBPS_CONFIG_FILE.m4
all: m4/GATBPS_CONFIG_FILE_SUBST.m4
all: m4/GATBPS_DEFINE_AT.m4
all: m4/GATBPS_DEFINE_DATE.m4
all: m4/GATBPS_MSG_NOTICE.m4
all: m4/GATBPS_PROG_AWK.m4
all: m4/GATBPS_PROG_DOXYGEN.m4
all: m4/gatbps_fatal.m4
all: m4/gatbps_notice.m4

build-aux/CC0-1.0-AC-COPYRIGHT.ac:
	$(GENERATE) $@

build-aux/CC0-1.0-AM-COPYRIGHT.am:
	$(GENERATE) $@

build-aux/DATE.sh:
	$(GENERATE) $@

build-aux/GATBPS_CONFIG_FILE_RULES.am:
	$(GENERATE) $@

build-aux/GATBPS_RECIPE_MARKER.am:
	$(GENERATE) $@

build-aux/GATBPS_V_PAD.am:
	$(GENERATE) $@

build-aux/VERSION.sh:
	$(GENERATE) $@

build-aux/doxygen.am:
	$(GENERATE) $@

build-aux/echo.sh:
	$(GENERATE) $@

dev-aux/CC0-1.0-commit.txt:
	$(GENERATE) $@

dev-aux/format.ac.vim:
	$(GENERATE) $@

dev-aux/format.am.vim:
	$(GENERATE) $@

m4/GATBPS_CONFIG_FILE.m4:
	$(GENERATE) $@

m4/GATBPS_CONFIG_FILE_SUBST.m4:
	$(GENERATE) $@

m4/GATBPS_DEFINE_AT.m4:
	$(GENERATE) $@

m4/GATBPS_DEFINE_DATE.m4:
	$(GENERATE) $@

m4/GATBPS_MSG_NOTICE.m4:
	$(GENERATE) $@

m4/GATBPS_PROG_AWK.m4:
	$(GENERATE) $@

m4/GATBPS_PROG_DOXYGEN.m4:
	$(GENERATE) $@

m4/gatbps_fatal.m4:
	$(GENERATE) $@

m4/gatbps_notice.m4:
	$(GENERATE) $@

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
