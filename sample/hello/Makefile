ifeq ($(OS),Windows_NT)
  EXEEXT = .exe
endif

hello: hello.c
	cc `pkg-config --cflags gtk4` hello.c -o hello$(EXEEXT) `pkg-config --libs gtk4`

clean:
	rm -f hello$(EXEEXT)
