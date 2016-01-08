#***************************************************
#	^> File Name: multi.mk
#	^> Author: AoEiuV020
#	^> Mail: 490674483@qq.com
#	^> Created Time: 2015/05/09
#***************************************************
#######�Զ����뵱ǰ�ļ���������.cpp������.o�Ϳ�ִ���ļ���
#######���C=CC�����.c,
#######���RELEASE=1��ͬʱ���ɶ�Ӧ.a��.so,
#######�Զ��жϲ���ϵͳ
ifeq ($(shell uname 2>&1),Linux)
	WINDOWS=0
else
	WINDOWS=1
endif
#######�������ж�ϵͳ�ǲ���WINDOWS,׼��׼����ν�ˣ����þͺá�����
ifeq ($(WINDOWS),1)
	TAREXT=exe
	RM=del /f
else
	TAREXT=out
	RM=rm -f
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
ifeq ($(RELEASE),1)
	RELEASELIB=liba libso
else
	RELEASE=0
endif
#######���а棬������.o�������.a��.so


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
