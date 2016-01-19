#	***************************************************
#		^> File Name: java.mk
#		^> Author: AoEiuV020
#		^> Mail: 490674483@qq.com
#		^> Created Time: 2016/01/19 - 22:54:49
#	***************************************************
n=Hello.java
bn:=$(basename $(n))
ECHO=echo $@:$? done...
all:javac java
	@$(ECHO)

javac:
	javac $(n)

java:
	java $(bn)

chname:
	sed -i "s/\<$(n)\>/$(N)/" makefile
