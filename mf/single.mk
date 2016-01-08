#***************************************************
#	^> File Name: single.mk
#	^> Author: AoEiuV020
#	^> Mail: 490674483@qq.com
#	^> Created Time: 2015/05/09
#***************************************************
#######�Զ����뵱ǰ�ļ���������.cpp������.o�Ϳ�ִ���ļ���
#######���C=CC�����.c,
#######���RELEASE=1��ͬʱ���ɶ�Ӧ.a��.so,
#######�Զ��жϲ���ϵͳ
#ifeq ($(shell uname 2>&1),Linux)
#	WINDOWS=0
#else
#	WINDOWS=1
#endif
WINDOWS=0
#######�������ж�ϵͳ�ǲ���WINDOWS,׼��׼����ν�ˣ����þͺá�����
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
#######������WINDOWS��һ���ĵط�������
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
#######���C������c����c++������

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
