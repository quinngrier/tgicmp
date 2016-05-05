all:

## begin_variables

GATBPS = 'gatbps'

## end_variables

## begin_rules

.PHONY: all

all:
	$(GATBPS) '--' 'CC0-1.0.txt'
	$(GATBPS) '--' 'build-aux/CC0-1.0-AC-COPYRIGHT.ac'
	$(GATBPS) '--' 'build-aux/DATE.sh'
	$(GATBPS) '--' 'build-aux/GATBPS_CONFIG_FILE_RULES.am'
	$(GATBPS) '--' 'build-aux/VERSION.sh'
	$(GATBPS) '--' 'dev-aux/CC0-1.0-commit.txt'
	$(GATBPS) '--' 'm4/GATBPS_DEFINE_DATE.m4'

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
