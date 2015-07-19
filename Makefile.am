include_HEADERS = $(srcdir)/tgicmp.h

$(builddir)/tgicmp.3: $(srcdir)/tgicmp.3.in
	sed -e 's|[@]PACKAGE_DATE@|$(PACKAGE_DATE)|g'       \
	    -e 's|[@]PACKAGE_VERSION@|$(PACKAGE_VERSION)|g' \
	    -e 's|[@]docdir@|$(docdir)|g'                   \
	    -e 's|[@]dvidir@|$(dvidir)|g'                   \
	    -e 's|[@]htmldir@|$(htmldir)|g'                 \
	    -e 's|[@]pdfdir@|$(pdfdir)|g'                   \
	    -e 's|[@]psdir@|$(psdir)|g'                     \
	    $? >$@
$(builddir)/tgicmp.h.3: $(builddir)/tgicmp.3; cp $? $@
$(builddir)/TGILT.3:    $(builddir)/tgicmp.3; cp $? $@
$(builddir)/TGIGT.3:    $(builddir)/tgicmp.3; cp $? $@
$(builddir)/TGILE.3:    $(builddir)/tgicmp.3; cp $? $@
$(builddir)/TGIGE.3:    $(builddir)/tgicmp.3; cp $? $@
$(builddir)/TGIEQ.3:    $(builddir)/tgicmp.3; cp $? $@
$(builddir)/TGINE.3:    $(builddir)/tgicmp.3; cp $? $@
man_MANS =
man_MANS += $(builddir)/tgicmp.3
man_MANS += $(builddir)/tgicmp.h.3
man_MANS += $(builddir)/TGILT.3
man_MANS += $(builddir)/TGIGT.3
man_MANS += $(builddir)/TGILE.3
man_MANS += $(builddir)/TGIGE.3
man_MANS += $(builddir)/TGIEQ.3
man_MANS += $(builddir)/TGINE.3
CLEANFILES = $(man_MANS)

dist_doc_DATA = $(srcdir)/CC0-1.0.txt

EXTRA_DIST =
EXTRA_DIST += $(srcdir)/DATE
EXTRA_DIST += $(srcdir)/DATE.sh
EXTRA_DIST += $(srcdir)/VERSION
EXTRA_DIST += $(srcdir)/VERSION.sh
EXTRA_DIST += $(srcdir)/tgicmp.3.in

$(srcdir)/PACKAGE.texi: $(srcdir)/PACKAGE.texi.in
	sed -e 's|[@]PACKAGE_DATE@|$(PACKAGE_DATE)|g'       \
	    -e 's|[@]PACKAGE_VERSION@|$(PACKAGE_VERSION)|g' \
	    $? >$@
EXTRA_DIST += $(srcdir)/PACKAGE.texi.in

info_TEXINFOS = tgicmp.texi
tgicmp_TEXINFOS =
tgicmp_TEXINFOS += $(srcdir)/CC0-1.0.appendix.texi
tgicmp_TEXINFOS += $(srcdir)/CC0-1.0-copying.texi
tgicmp_TEXINFOS += $(srcdir)/PACKAGE.texi

##
## The authors of this file have waived all copyright and
## related or neighboring rights to the extent permitted by
## law as described by the CC0 1.0 Universal Public Domain
## Dedication. You should have received a copy of the full
## dedication along with this file, typically as a file
## named <CC0-1.0.txt>. If not, it may be available at
## <https://creativecommons.org/publicdomain/zero/1.0/>.
##
