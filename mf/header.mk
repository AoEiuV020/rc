#	***************************************************
#		^> File Name: header.mk
#		^> Author: AoEiuV020
#		^> Mail: 490674483@qq.com
#		^> Created Time: 2015/05/10 - 13:27:58
#	***************************************************

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
	MDOBJ=if not exist $(subst /,\,$(OBJSDIR)) mkdir $(subst /,\,$(OBJSDIR))
	MDDEP=if not exist $(subst /,\,$(DEPSDIR)) mkdir $(subst /,\,$(DEPSDIR))
	RM=del /f /s /q $(TARGET) $(subst /,\,$(OBJS)) $(subst /,\,$(DEPS))
	NULL=2>&1 1>nul
else
	TAREXT=out
	MDOBJ=mkdir -p $(OBJSDIR)
	MDDEP=mkdir -p $(DEPSDIR)
	RM=rm -rf $(TARGET) $(OBJS) $(DEPS)
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
DEPSDIR=dep/
DEPS=$(patsubst %.$(SRCEXT),$(DEPSDIR)%.d,$(notdir $(SRCS)))
LIBS=

ECHO=echo $@:$? done...

.PHONY:all mkdir depend clean

all:mkdir depend $(TARGET)
	-@$(ECHO)

mkdir:
	-@$(MDOBJ)
	-@$(MDDEP)
	-@$(ECHO)

depend:$(DEPS)
	-@$(ECHO)

sinclude $(DEPS)

$(DEPSDIR)%.d:$(SRCSDIR)%.$(SRCEXT)
	$($(C)) -MM $^ $($(C)FLAGS) >> $@

$(TARGET):$(OBJS)
	$($(C)) $^ $(LDFLAGS) $(LIBS) -o $@

clean:
	-@$(RM) $(NULL)
	-@$(ECHO)
