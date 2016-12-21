#!/bin/sh
dir=$(dirname $0)
cd ${dir}
echo ${PWD}
ln -sf ${PWD}/.vimrc ~/.vimrc
#if [ -f ~/.bashrc ]
#then
#	mv ~/.bashrc ~/local.bashrc
#fi
ln -sf ${PWD}/.bashrc ~/.bashrc
git config --global user.email "aoeiuv020@gmail.com"
git config --global user.name "AoEiuV020"
git config --global push.default simple
