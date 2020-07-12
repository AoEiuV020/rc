#!/bin/bash
echo stop clash...
if [ $"x$USER" != "xroot" ]
then
    echo need root...
    exit 1
fi
cd /etc/clash
export user=${user:=aoeiuv}
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
which dconf && sudo -u $user ./system-noproxy.sh
