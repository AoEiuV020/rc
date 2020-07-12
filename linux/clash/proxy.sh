#!/bin/sh
echo setup proxy...
export http_proxy_host='127.0.0.1'
export socks_proxy_host='127.0.0.1'
export http_proxy_port='1082'
export socks_proxy_port='1081'
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
which dconf && su - aoeiuv <<EOF
dconf write /system/proxy/http/host "'$http_proxy_host'"
dconf write /system/proxy/http/port "$http_proxy_port"
dconf write /system/proxy/https/host "'$http_proxy_host'"
dconf write /system/proxy/https/port "$http_proxy_port"
dconf write /system/proxy/ftp/host "'$http_proxy_host'"
dconf write /system/proxy/ftp/port "$http_proxy_port"
dconf write /system/proxy/socks/host "'$socks_proxy_host'"
dconf write /system/proxy/socks/port "$socks_proxy_port"
dconf write /system/proxy/mode "'manual'"
EOF