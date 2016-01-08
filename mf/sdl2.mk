#name...
n=hello
#extension...
x=.c
CC=gcc
SDL_HOME = D:\Development\SDL\SDL2-devel-2.0.3-mingw
SDL2_HOME = $(SDL_HOME)\SDL2-2.0.3\i686-w64-mingw32
INCLUDE_PATHS = -I$(SDL2_HOME)\include
LIBRARY_PATHS = -L$(SDL2_HOME)\lib
COMPILER_FLAGS = -lmingw32 -mwindows -mconsole -Wall -save-temps -std=c99
LINKER_FLAGS = -lmingw32 -lSDL2main -lSDL2
$(n).exe : $(n)$(x)
	$(CC) $(n)$(x) $(INCLUDE_PATHS) $(LIBRARY_PATHS) $(COMPILER_FLAGS) $(LINKER_FLAGS) -o $(n).exe


.PHONY : clear
clear:
	del *.i *.ii *.s *.o *.exe
