prefix = /usr/local
datarootdir = $(prefix)/share
includedir = $(prefix)/include
mandir = $(datarootdir)/man
man3dir = $(mandir)/man3
man3ext = .3

$(tgicmp)all: \
$(tgicmp)test$(EXEEXT) \
$(tgicmp)test.o \

$(tgicmp)check: \
$(tgicmp)test$(EXEEXT) \

	$(@D)/test$(EXEEXT)

$(tgicmp)clean:
	rm -f -- $(tgicmp)test$(EXEEXT)
	rm -f -- $(tgicmp)test.o

$(tgicmp)install: \
$(tgicmp)installdirs \
$(tgicmp)tgicmp.3 \
$(tgicmp)tgicmp.h \

	install -- $(tgicmp)tgicmp.3 $(DESTDIR)$(man3dir)/tgicmp$(man3ext)
	install -- $(tgicmp)tgicmp.h $(DESTDIR)$(includedir)/tgicmp.h

$(tgicmp)installdirs:
	install -d -- $(DESTDIR)$(includedir)
	install -d -- $(DESTDIR)$(man3dir)

$(tgicmp)test$(EXEEXT): \
$(tgicmp)test.o \

	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ \
$(tgicmp)test.o \
$(LOADLIBES) $(LDLIBS)

$(tgicmp)test.o: \
$(tgicmp)test.c \
$(tgicmp)tgicmp.h \

	cd -- $(@D) && $(CC) $(CFLAGS) -c test.c

#
# The authors of this file have waived all copyright and
# related or neighboring rights to the extent permitted by
# law as described by the CC0 1.0 Universal Public Domain
# Dedication. You should have received a copy of the full
# dedication along with this file, typically as a file
# named <CC0-1.0.txt>. If not, it may be available at
# <https://creativecommons.org/publicdomain/zero/1.0/>.
#
