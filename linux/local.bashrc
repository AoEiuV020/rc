alias off='poweroff'
alias offon='reboot'
alias grubnext='grub-reboot --boot-directory=/boot/efi/boot '
alias grubdefault='grub-set-default --boot-directory=/boot/efi/boot '
alias clip='xclip -selection c'
alias cpwd='echo -n $PWD|clip'
alias padoff='synclient touchpadoff=1'
alias padon='synclient touchpadoff=0'
alias leave='date;read -t 7200&&date||systemctl poweroff'
alias es='espeak -vzh'
apt='/var/cache/apt/archives'
pkg='/var/cache/pacman/pkg'
code='/mnt/sext/code'
grub=/boot/efi/boot/grub
git="$code/git"
rc="$git/rc"
export VISUAL="vim"
export EDITOR="vim"
#export GRADLE_OPTS='-DsocksProxyHost=127.0.0.1 -DsocksProxyPort=1081'
export PROXYCHAINS_CONF_FILE=${PROXYCHAINS_CONF_FILE}
export PROXYCHAINS_QUIET_MODE=${PROXYCHAINS_QUIET_MODE:-1}
sast() {
    export PROXYCHAINS_CONF_FILE=/mnt/ext/tools/proxychains/sast.conf
}
sast_out() {
    export PROXYCHAINS_CONF_FILE=/mnt/ext/tools/proxychains/sast_out.conf
}
fgradle() {
    GRADLE="gradle"
    GRADLEW="./gradlew"
    if [ -x $GRADLEW ]
    then
        GRADLE=$GRADLEW
    fi
}
gtest() {
    fgradle
    $GRADLE test --tests "*$1*" $2 $3 $4
}
gcommit() {
    fgradle
    $GRADLE clean test &&
    git add . &&
    git commit -F commit
}
gpush() {
    rm -rf .git/refs/original/ &&
    git reflog expire --expire=now --all &&
    git gc &&
    git gc --prune=now &&
    git gc --aggressive --prune=now &&
    git push $1 $2 $3 $4
}
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
    dconf write /system/proxy/http/host "'$http_proxy_host'"
    dconf write /system/proxy/http/port "$http_proxy_port"
    dconf write /system/proxy/https/host "'$http_proxy_host'"
    dconf write /system/proxy/https/port "$http_proxy_port"
    dconf write /system/proxy/ftp/host "'$http_proxy_host'"
    dconf write /system/proxy/ftp/port "$http_proxy_port"
    dconf write /system/proxy/socks/host "'$socks_proxy_host'"
    dconf write /system/proxy/socks/port "$socks_proxy_port"
    dconf write /system/proxy/mode "'manual'"
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
    dconf write /system/proxy/mode "'none'"
}
