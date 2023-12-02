#!/bin/sh
cd $(dirname $0)
linux="$(dirname $PWD)/linux"
echo ${PWD}
ln -sf ${linux}/.vimrc ~/.vimrc
zshrc=~/.zshrc
if [ -f $zshrc ] && [ ! -h $zshrc ]
then
	mv $zshrc $zshrc.old
fi
ln -sf ${PWD}/.zshrc $zshrc
git config --global user.email "aoeiuv020@gmail.com"
git config --global user.name "AoEiuV020"
git config --global push.default simple
git config --global core.editor vim
