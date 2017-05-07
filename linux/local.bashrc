alias off='poweroff'
alias offon='reboot'
alias grubnext='grub-reboot --boot-directory=/boot/efi/boot '
alias grubdefault='grub-set-default --boot-directory=/boot/efi/boot '
alias clip='xclip -selection c'
alias cpwd='echo -n $PWD|clip'
alias padoff='synclient touchpadoff=1'
alias padon='synclient touchpadoff=0'
alias leave='date;read -t 7200&&date||systemctl poweroff'
apt='/var/cache/apt/archives'
pkg='/var/cache/pacman/pkg'
code='/mnt/ext/code'
grub=/boot/efi/boot/grub
git="$code/git"
rc="$git/rc"
export VISUAL="vim"
export EDITOR="vim"
export GRADLE_OPTS='-DsocksProxyHost=127.0.0.1 -DsocksProxyPort=1080'
export PROXYCHAINS_CONF_FILE=${PROXYCHAINS_CONF_FILE}
export PROXYCHAINS_QUIET_MODE=${PROXYCHAINS_QUIET_MODE:-1}
sast() {
    export PROXYCHAINS_CONF_FILE=/mnt/ext/tools/proxychains/sast.conf
}
sast_out() {
    export PROXYCHAINS_CONF_FILE=/mnt/ext/tools/proxychains/sast_out.conf
}
