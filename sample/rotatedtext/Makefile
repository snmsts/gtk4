ifeq ($(OS),Windows_NT)
  EXEEXT = .exe
endif

rotated$(EXEEXT): rotated.c
	cc `pkg-config --cflags gtk4` $< -o $@ `pkg-config --libs gtk4`

clean:
	rm -f rotated$(EXEEXT)
