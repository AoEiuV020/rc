alias off='poweroff'
alias offon='reboot'
alias grubnext='grub-reboot --boot-directory=/boot/efi/boot '
alias grubdefault='grub-set-default --boot-directory=/boot/efi/boot '
alias clip='xclip -selection c'
alias padoff='synclient touchpadoff=1'
alias padon='synclient touchpadoff=0'
alias leave='sleep 7200&&systemctl poweroff'
apt='/var/cache/apt/archives'
pkg='/var/cache/pacman/pkg'
code='/mnt/ext/code'
grub=/boot/efi/boot/grub
git="$code/git"
rc="$git/rc"
export VISUAL="vim"
export EDITOR="vim"
