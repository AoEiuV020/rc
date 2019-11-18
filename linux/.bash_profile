#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
[[ -e ~/bin ]] && PATH=~/bin:$PATH
[[ -e ~/.local/bin ]] && PATH=~/.local/bin:$PATH
