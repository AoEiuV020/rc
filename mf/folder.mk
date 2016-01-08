#***************************************************
#	^> File Name: folder.mk
#	^> Author: AoEiuV020
#	^> Mail: 490674483@qq.com
#	^> Created Time: 2015/05/09 - 21:24:26
#***************************************************
#######���ļ��а汾��
#######�Զ����뵱$(SRCSDIR)������.cpp��
#######��$(OBJSDIR)������.o��
#######�ڵ�ǰĿǰ���ɿ�ִ���ļ���
#######���C=CC�����.c,
#######�Զ��жϲ���ϵͳ
ifneq ($(shell uname 2>&1),Linux)
	WINDOWS=1
endif
#######�������ж�ϵͳ�ǲ���WINDOWS,׼��׼����ν�ˣ����þͺá�����
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
#######������WINDOWS��һ���ĵط�������
CC=gcc
CXX=g++
C=CXX
ifeq ($(C),CXX)
	SRCEXT=cpp
else
	SRCEXT=c
endif
#######���C������c����c++������


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
