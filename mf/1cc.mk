#######自动判断操作系统
ifeq ($(shell uname 2>&1),Linux)
	WINDOWS=0
else
	WINDOWS=1
endif
#######上面是判断系统是不是WINDOWS,准不准无所谓了，能用就好。。。
ifeq ($(WINDOWS),1)
	PS=\\
#PathSeparator
	TAREXT=exe
	RM=del /f
else
	PS=/
	TAREXT=out
	RM=rm -f
endif
#######上面是WINDOWS不一样的地方。。。
n=hello
$(n).$(TAREXT):$(n).c
	gcc -Wall -std=c99 --save-temps -o $(n).$(TAREXT) $(n).c
	.$(PS)$(n).$(TAREXT)
.PHONY:clean
.IGNORE:clean
clean:
	$(RM) *.i *.o *.s *.$(TAREXT)


