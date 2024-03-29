alias start='xdg-open'
alias off='poweroff'
alias offon='reboot'
alias grubnext='grub-reboot --boot-directory=/boot/efi/boot '
alias grubdefault='grub-set-default --boot-directory=/boot/efi/boot '
alias clip='xclip -selection c'
alias cpwd='echo -n $PWD|clip'
alias padoff='synclient touchpadoff=1'
alias padon='synclient touchpadoff=0'
alias leave='date;read -t 7200&&date||systemctl poweroff'
alias sus='systemctl suspend'
alias es='espeak -vzh'
apt='/var/cache/apt/archives'
pkg='/var/cache/pacman/pkg'
code='/mnt/wext/code'
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
