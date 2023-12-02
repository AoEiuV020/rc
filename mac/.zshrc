alias ls='ls -G'
alias grep='grep --color=auto'
default_ps()
{
	PS1='%B%F{red}[%F{green}%?%F{blue}%n%F{red}@%F{magenta}%m%F{red}:%F{yellow}%~%F{red}]%F{green}%#%F{cyan}$%f '
}
short_ps()
{
	PS1='%B%F{red}[%F{yellow}%~%F{red}]%F{green}%#%F{cyan}$%f '
}
default_ps
set -o vi

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
