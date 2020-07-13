
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
proxy() {
    http_proxy_host='127.0.0.1'
    socks_proxy_host='127.0.0.1'
    http_proxy_port='1082'
    socks_proxy_port='1081'
    export ALL_PROXY="socks://$socks_proxy_host:$socks_proxy_port/"
    export FTP_PROXY="http://$http_proxy_host:$http_proxy_port/"
    export HTTPS_PROXY="http://$http_proxy_host:$http_proxy_port/"
    export HTTP_PROXY="http://$http_proxy_host:$http_proxy_port/"
    export NO_PROXY="localhost,127.0.0.0/8,::1"
    export all_proxy="socks://$socks_proxy_host:$socks_proxy_port/"
    export ftp_proxy="http://$http_proxy_host:$http_proxy_port/"
    export http_proxy="http://$http_proxy_host:$http_proxy_port/"
    export https_proxy="http://$http_proxy_host:$http_proxy_port/"
    export no_proxy="localhost,127.0.0.0/8,::1"
    which dconf &>/dev/null && (
    dconf write /system/proxy/http/host "'$http_proxy_host'"
    dconf write /system/proxy/http/port "$http_proxy_port"
    dconf write /system/proxy/https/host "'$http_proxy_host'"
    dconf write /system/proxy/https/port "$http_proxy_port"
    dconf write /system/proxy/ftp/host "'$http_proxy_host'"
    dconf write /system/proxy/ftp/port "$http_proxy_port"
    dconf write /system/proxy/socks/host "'$socks_proxy_host'"
    dconf write /system/proxy/socks/port "$socks_proxy_port"
    dconf write /system/proxy/mode "'manual'"
    )
}
noproxy() {
    unset ALL_PROXY
    unset FTP_PROXY
    unset HTTPS_PROXY
    unset HTTP_PROXY
    unset NO_PROXY
    unset all_proxy
    unset ftp_proxy
    unset http_proxy
    unset https_proxy
    unset no_proxy
    which dconf &>/dev/null && (
    dconf write /system/proxy/mode "'none'"
    )
}
