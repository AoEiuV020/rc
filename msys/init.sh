#!/bin/sh
#	***************************************************
#		^> File Name: init.sh
#		^> Author: AoEiuV020
#		^> Mail: 490674483@qq.com
#		^> Created Time: 2016/03/11 - 11:08:26
#	***************************************************
dir=$(dirname %0)
cd ${dir}
echo ${PWD}
ln -f ${PWD}/my.sh ~
