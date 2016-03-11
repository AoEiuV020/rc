#!/bin/sh
#	***************************************************
#		^> File Name: my.sh
#		^> Author: AoEiuV020
#		^> Mail: 490674483@qq.com
#		^> Created Time: 2016/01/22 - 16:27:07
#	***************************************************

ANDROID_HOME=/D/aoeiuv/Android
SDK_HOME=${ANDROID_HOME}/sdk
ADT_HOME=${ANDROID_HOME}/ant
case $1 in
	android)
		PATH=${SDK_HOME}/tools:${PATH}
		PATH=${SDK_HOME}/platform-tools:${PATH}
		PATH=${ADT_HOME}/bin:${PATH}
		export ANT_OPTS=-Dfile.encoding=UTF-8
		;;

	adb)
		PATH="${SDK_HOME}/platform-tools:${PATH}"
		;;

	mysql)
		PATH="/c/Program Files/MySQL/MySQL Server 5.6/bin:${PATH}"
		;;

	*)
		echo $1 unknown...
		;;
esac
