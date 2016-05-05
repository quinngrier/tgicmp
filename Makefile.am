## begin_variables

include_HEADERS =
include_HEADERS += tgicmp.h

dist_doc_DATA = $(srcdir)/CC0-1.0.txt

EXTRA_DIST =
EXTRA_DIST += $(srcdir)/DATE
EXTRA_DIST += $(srcdir)/DATE.sh
EXTRA_DIST += $(srcdir)/VERSION
EXTRA_DIST += $(srcdir)/tgicmp.3.in
EXTRA_DIST += build-aux/VERSION.sh

$(builddir)/PACKAGE.texi: $(srcdir)/PACKAGE.texi.in
	sed -e 's|@PACKAGE_DATE[@]|$(PACKAGE_DATE)|g'       \
	    -e 's|@PACKAGE_VERSION[@]|$(PACKAGE_VERSION)|g' \
	    $? >$@
EXTRA_DIST += $(srcdir)/PACKAGE.texi.in

info_TEXINFOS =
info_TEXINFOS += tgicmp.texi

tgicmp_TEXINFOS =
tgicmp_TEXINFOS += $(builddir)/PACKAGE.texi
tgicmp_TEXINFOS += $(srcdir)/AUTHORS.texi
tgicmp_TEXINFOS += $(srcdir)/CC0-1.0.appendix.texi
tgicmp_TEXINFOS += $(srcdir)/CC0-1.0.copying.texi
tgicmp_TEXINFOS += $(srcdir)/MIRRORS.texi
tgicmp_TEXINFOS += $(srcdir)/NEWS.texi

## end_variables

## begin_includes

include $(srcdir)/build-aux/GATBPS_CONFIG_FILE_RULES.am

## end_includes

include $(srcdir)/build-aux/CC0-1.0-AM-COPYRIGHT.am

##
## The authors of this file have waived all copyright and
## related or neighboring rights to the extent permitted by
## law as described by the CC0 1.0 Universal Public Domain
## Dedication. You should have received a copy of the full
## dedication along with this file, typically as a file
## named <CC0-1.0.txt>. If not, it may be available at
## <https://creativecommons.org/publicdomain/zero/1.0/>.
##
