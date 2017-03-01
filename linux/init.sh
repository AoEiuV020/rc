#!/bin/sh
dir=$(dirname $0)
cd ${dir}
echo ${PWD}
ln -sf ${PWD}/.vimrc ~/.vimrc
if [ -f ~/.bashrc ] && [ ! -h ~/.bashrc ]
then
	mv ~/.bashrc ~/.bashrc.old
fi
ln -sf ${PWD}/.bashrc ~/.bashrc
git config --global user.email "aoeiuv020@gmail.com"
git config --global user.name "AoEiuV020"
git config --global push.default simple
git config --global core.editor vim
