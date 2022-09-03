all: cairo.lisp

# on ubuntu 22.04 x86_64

# pkg-config --cflags gtk4 
%.lisp: %.i
	swig -swig-lisp -cffi \
		-I./$<.dummy \
		-I/usr/lib/gcc/x86_64-linux-gnu/11/include \
		-I/usr/local/include \
		-I/usr/include/x86_64-linux-gnu \
		-I/usr/include \
		\
		-I/usr/include/gtk-4.0 \
		-I/usr/include/gio-unix-2.0 \
		-I/usr/include/cairo \
		-I/usr/include/pango-1.0 \
		-I/usr/include/harfbuzz \
		-I/usr/include/pango-1.0 \
		-I/usr/include/fribidi \
		-I/usr/include/harfbuzz \
		-I/usr/include/gdk-pixbuf-2.0 \
		-I/usr/include/x86_64-linux-gnu \
		-I/usr/include/cairo \
		-I/usr/include/pixman-1 \
		-I/usr/include/uuid \
		-I/usr/include/freetype2 \
		-I/usr/include/libpng16 \
		-I/usr/include/graphene-1.0 \
		-I/usr/lib/x86_64-linux-gnu/graphene-1.0/include \
		-I/usr/include/libmount \
		-I/usr/include/blkid \
		-I/usr/include/glib-2.0 \
		-I/usr/lib/x86_64-linux-gnu/glib-2.0/include \
		-importall $<

%.lisp.diff: swig_%.lisp %.lisp
	diff $^ > /dev/null || diff -u $^ > $@ || true

%.lisp: swig_%.lisp %.lisp.diff
	cp $< $@
	patch $@ $@.diff

clean:
	rm -f *.lisp
