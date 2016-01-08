#***************************************************
#	^> File Name: multi.mk
#	^> Author: AoEiuV020
#	^> Mail: 490674483@qq.com
#	^> Created Time: 2015/05/09
#***************************************************
#######自动编译当前文件夹下所有.cpp，生成.o和可执行文件，
#######如果C=CC则编译.c,
#######如果RELEASE=1则同时生成对应.a和.so,
#######自动判断操作系统
ifeq ($(shell uname 2>&1),Linux)
	WINDOWS=0
else
	WINDOWS=1
endif
#######上面是判断系统是不是WINDOWS,准不准无所谓了，能用就好。。。
ifeq ($(WINDOWS),1)
	TAREXT=exe
	RM=del /f
else
	TAREXT=out
	RM=rm -f
endif
#######上面是WINDOWS不一样的地方。。。
CC=gcc
CXX=g++
C=CXX
ifeq ($(C),CXX)
	SRCEXT=cpp
else
	SRCEXT=c
endif
#######这个C决定是c还是c++。。。
ifeq ($(RELEASE),1)
	RELEASELIB=liba libso
else
	RELEASE=0
endif
#######发行版，把所有.o都打包成.a和.so


INCLUDES=-I.
CFLAGS=-Wall -std=c99 -O2 -g $(INCLUDES)
CXXFLAGS=-Wall -std=c++11 -O2 -g $(INCLUDES)
LDFLAGS=-L.
AR=ar
ARFLAGS=rc
TARGET=$(notdir $(CURDIR)).$(TAREXT)
SRCS=$(wildcard *.$(SRCEXT))
OBJS=$(patsubst %.$(SRCEXT),%.o,$(SRCS))
LIBS=




ECHO=echo $@:$? done...


.PHONY:all liba libso clean


all:$(TARGET) $(RELEASELIB)
	$(ECHO)


$(TARGET):$(OBJS)
	$($(C)) $^ $(LDFLAGS) $(LIBS) -o $@


$(OBJS):%.o:%.$(SRCEXT)
	$($(C)) -c $^ $($(C)FLAGS) -o $@


liba:$(OBJS:%.o=lib%.a)
	$(ECHO)


libso:$(OBJS:%.o=lib%.so)
	$(ECHO)


$(OBJS:%.o=lib%.a):lib%.a:%.o
	-$(AR) $(ARFLAGS) $@ $^


$(OBJS:%.o=lib%.so):lib%.so:%.o
	-$($(C)) -shared $^ -o $@


clean:
	-$(RM) $(OBJS) $(OBJS:%.o=lib%.a) $(OBJS:%.o=lib%.so) $(TARGET)
	$(ECHO)
