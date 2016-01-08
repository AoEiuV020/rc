#***************************************************
#	^> File Name: folder.mk
#	^> Author: AoEiuV020
#	^> Mail: 490674483@qq.com
#	^> Created Time: 2015/05/09 - 21:24:26
#***************************************************
#######多文件夹版本，
#######自动编译当$(SRCSDIR)下所有.cpp，
#######在$(OBJSDIR)下生成.o，
#######在当前目前生成可执行文件，
#######如果C=CC则编译.c,
#######自动判断操作系统
ifneq ($(shell uname 2>&1),Linux)
	WINDOWS=1
endif
#######上面是判断系统是不是WINDOWS,准不准无所谓了，能用就好。。。
ifdef WINDOWS
	TAREXT=exe
	MD=if not exist $(subst /,\,$(OBJSDIR)) mkdir $(subst /,\,$(OBJSDIR))
	RM=del /f /s /q $(TARGET) $(subst /,\,$(OBJS))
	NULL=2>&1 1>nul
else
	TAREXT=out
	MD=mkdir -p $(OBJSDIR)
	RM=rm -rf $(TARGET) $(OBJS)
	NULL=2>&1 1>/dev/null
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


INCLUDES=-I.
CFLAGS=-Wall -std=c99 -O2 -g $(INCLUDES)
CXXFLAGS=-Wall -std=c++11 -O2 -g $(INCLUDES)
LDFLAGS=-L.
TARGET=$(notdir $(CURDIR)).$(TAREXT)
SRCSDIR=src/
SRCS=$(wildcard $(SRCSDIR)*.$(SRCEXT))
OBJSDIR=obj/
OBJS=$(patsubst %.$(SRCEXT),$(OBJSDIR)%.o,$(notdir $(SRCS)))
LIBS=




ECHO=echo $@:$? done...


.PHONY:all mkdir clean


all:mkdir $(TARGET)
	-@$(ECHO)


mkdir:
	-@$(MD)
	-@$(ECHO)


$(TARGET):$(OBJS)
	$($(C)) $^ $(LDFLAGS) $(LIBS) -o $@


$(OBJSDIR)%.o:$(SRCSDIR)%.$(SRCEXT)
	$($(C)) -c $^ $($(C)FLAGS) -o $@


clean:
	-@$(RM) $(NULL)
	-@$(ECHO)
