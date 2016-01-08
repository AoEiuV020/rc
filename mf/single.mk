#***************************************************
#	^> File Name: single.mk
#	^> Author: AoEiuV020
#	^> Mail: 490674483@qq.com
#	^> Created Time: 2015/05/09
#***************************************************
#######自动编译当前文件夹下所有.cpp，生成.o和可执行文件，
#######如果C=CC则编译.c,
#######如果RELEASE=1则同时生成对应.a和.so,
#######自动判断操作系统
#ifeq ($(shell uname 2>&1),Linux)
#	WINDOWS=0
#else
#	WINDOWS=1
#endif
WINDOWS=0
#######上面是判断系统是不是WINDOWS,准不准无所谓了，能用就好。。。
ifeq ($(WINDOWS),1)
	SHELL=cmd.exe
	TAREXT=exe
	RUN=
	RM=del /f
else
	TAREXT=out
	RUN=./
	RM=rm -f
endif
#######上面是WINDOWS不一样的地方。。。
n=temp.c
SRCEXT:=$(suffix $(n))
CC=gcc
CXX=g++
ifeq ($(SRCEXT),$(findstring $(SRCEXT),.c .i))
	C=CC
	FLAGS=CFLAGS
else
	C=CXX
	FLAGS=CXXFLAGS
endif
#######这个C决定是c还是c++。。。

INCLUDES=-I.
CFLAGS=-Wall -std=gnu99 -O2 -g $(INCLUDES)
CXXFLAGS=-Wall -std=c++11 -O2 -g $(INCLUDES)
#TARGET=$(notdir $(CURDIR)).$(TAREXT)
TARGET=$(patsubst %$(SRCEXT),%.$(TAREXT),$(n))
OBJS=$(patsubst %$(SRCEXT),%.o,$(n))
LIBS=
LDFLAGS=$(LIBS) -L.




ECHO=echo $@:$? done...


.PHONY:all clean chname


all:$(TARGET)
	#$(RUN)$<
	@$(ECHO)


$(TARGET):$(OBJS)
	$($(C)) $^ $(LDFLAGS) -o $@


$(OBJS):%.o:%$(SRCEXT)
	$($(C)) -c $^ $($(FLAGS)) -o $@


clean:
	-@$(RM) *.o *.s *.i *.ii *.out *.exe *.d
	@$(ECHO)

chname:
	sed -i "s/\<$(n)\>/$(N)/" makefile
