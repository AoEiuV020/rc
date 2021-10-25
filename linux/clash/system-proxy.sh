#!/bin/bash
echo setup system proxy...
export http_proxy_host='proxyhost'
export socks_proxy_host=$http_proxy_host
export http_proxy_port='1082'
export socks_proxy_port='1081'
export ALL_PROXY="socks5://$socks_proxy_host:$socks_proxy_port/"
# ftp代理会导致wget无法下载ftp文件，
unset FTP_PROXY
export HTTPS_PROXY="http://$http_proxy_host:$http_proxy_port/"
export HTTP_PROXY="http://$http_proxy_host:$http_proxy_port/"
# 写死127.0.0.1因为flutter的websocket需要，
export NO_PROXY="localhost,127.0.0.1,127.0.0.0/8,::1"
export all_proxy=$ALL_PROXY
unset ftp_proxy
export http_proxy=$HTTP_PROXY
export https_proxy=$HTTPS_PROXY
export no_proxy=$NO_PROXY

which dconf &>/dev/null && (
dconf write /system/proxy/http/host "'$http_proxy_host'"
dconf write /system/proxy/http/port "$http_proxy_port"
dconf write /system/proxy/https/host "'$http_proxy_host'"
dconf write /system/proxy/https/port "$http_proxy_port"
dconf reset /system/proxy/ftp/host
dconf reset /system/proxy/ftp/port
dconf write /system/proxy/socks/host "'$socks_proxy_host'"
dconf write /system/proxy/socks/port "$socks_proxy_port"
dconf write /system/proxy/ignore-hosts "['localhost', '127.0.0.1', '127.0.0.0/8', '::1']"
dconf write /system/proxy/mode "'manual'"
) || true
