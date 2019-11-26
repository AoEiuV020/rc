
localrc="local.bashrc"
if [ -f ~/${localrc} ]
then
	source ~/${localrc}
fi

alias indent='indent -bap -bli0 -i4 -l99 -ncs -npcs -npsl -fca -lc79 -fc1 -ts4  -cdb -sc'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
defult_ps()
{
	PS1='\[\e[1m\]\[\e[31m\][\[\e[32m\]$?\[\e[34m\]\u\[\e[31m\]@\[\e[35m\]\h\[\e[31m\]:\[\e[33m\]\w\[\e[31m\]]\[\e[32m\]\#\[\e[36m\]\$\[\e[m\] '
}
short_ps()
{
	PS1='\[\e[1m\]\[\e[31m\][\[\e[33m\]\W\[\e[31m\]]\[\e[32m\]\#\[\e[36m\]\$\[\e[m\] '
}
defult_ps
set -o vi
shopt -s direxpand
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
