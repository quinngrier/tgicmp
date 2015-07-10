include_HEADERS = tgicmp.h

tgicmp.3: tgicmp.3.in
	sed -e 's|[@]PACKAGE_VERSION@|$(PACKAGE_VERSION)|g' \
	    -e 's|[@]dvidir@|$(dvidir)|g'                   \
	    -e 's|[@]htmldir@|$(htmldir)|g'                 \
	    -e 's|[@]pdfdir@|$(pdfdir)|g'                   \
	    -e 's|[@]psdir@|$(psdir)|g'                     \
	    $? >$@
tgicmp.h.3: tgicmp.3; cp $? $@
TGILT.3:    tgicmp.3; cp $? $@
TGIGT.3:    tgicmp.3; cp $? $@
TGILE.3:    tgicmp.3; cp $? $@
TGIGE.3:    tgicmp.3; cp $? $@
TGIEQ.3:    tgicmp.3; cp $? $@
TGINE.3:    tgicmp.3; cp $? $@
man_MANS = tgicmp.3 tgicmp.h.3 \
           TGILT.3 TGIGT.3 TGILE.3 TGIGE.3 TGIEQ.3 TGINE.3
CLEANFILES = $(man_MANS)

EXTRA_DIST = \
  CC0-1.0.txt \
  VERSION \
  VERSION.sh \
  tgicmp.3.in

info_TEXINFOS = tgicmp.texi
tgicmp_TEXINFOS = \
  CC0-1.0-appendix.texi \
  CC0-1.0-copying.texi

##
## The authors of this file have waived all copyright and
## related or neighboring rights to the extent permitted by
## law as described by the CC0 1.0 Universal Public Domain
## Dedication. You should have received a copy of the full
## dedication along with this file, typically as a file
## named <CC0-1.0.txt>. If not, it may be available at
## <https://creativecommons.org/publicdomain/zero/1.0/>.
##
