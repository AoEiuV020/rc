#!/bin/sh
#	***************************************************
#		^> File Name: init.sh
#		^> Author: AoEiuV020
#		^> Mail: 490674483@qq.com
#		^> Created Time: 2016/01/31 - 23:07:20
#	***************************************************
dir=$(dirname %0)
cd ${dir}
echo ${PWD}
ln -sf ${PWD}/.vimrc ~/.vimrc
if [ -f ~/.bashrc ]
then
	mv ~/.bashrc ~/local.bashrc
fi
ln -sf ${PWD}/.bashrc ~/.bashrc
git config --global user.email "490674483@qq.com"
git config --global user.name "AoEiuV020"
git config --global push.default simple
