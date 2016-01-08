alias grubnext='grub-reboot --boot-directory=/boot/efi/boot '
alias clip='xclip -selection c'
alias padoff='synclient touchpadoff=1'
alias padon='synclient touchpadoff=0'
alias gitpull='git pull origin master'
alias gitpush='git commit -a -m "AoEiuV020 commit..." ;git push -u origin master'

apt='/var/cache/apt/archives'
pkg='/var/cache/pacman/pkg'
code='/mnt/ext/code'
git="$code/git"
bashrc='/mnt/ext/rc/.bashrc'
host='/mnt/ext/host'
open="$host/openshift"
install='/mnt/ext/arch/install'

alias indent='indent -bap -bli0 -i4 -l99 -ncs -npcs -npsl -fca -lc79 -fc1 -ts4  -cdb -sc'
alias ls='ls -h --color=auto'
PS1='\[\e[1m\]\[\e[31m\][\[\e[32m\]$?\[\e[34m\]\u\[\e[31m\]@\[\e[35m\]\h\[\e[31m\]:\[\e[33m\]\w\[\e[31m\]]\[\e[32m\]\#\[\e[36m\]\$\[\e[m\]'
set -o vi
