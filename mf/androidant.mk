#	***************************************************
#		^> File Name: makefile
#		^> Author: AoEiuV020
#		^> Mail: 490674483@qq.com
#		^> Created Time: 2015/12/23 - 20:28:14
#	***************************************************
.PHONY:all ndk build install start
all:ndk build start
	echo OK...

ndk:
	-ndk-build

build:
	ant debug install

install:
	adb install -r bin/Hello-debug.apk

start:
	adb shell am start -n com.aoeiuv020.hello/.Main
