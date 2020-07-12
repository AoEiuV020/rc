#!/bin/sh
echo setup proxy...
export http_proxy_host='127.0.0.1'
export socks_proxy_host='127.0.0.1'
export http_proxy_port='1082'
export socks_proxy_port='1081'
declare -x ALL_PROXY="socks://$socks_proxy_host:$socks_proxy_port/"
declare -x FTP_PROXY="http://$http_proxy_host:$http_proxy_port/"
declare -x HTTPS_PROXY="http://$http_proxy_host:$http_proxy_port/"
declare -x HTTP_PROXY="http://$http_proxy_host:$http_proxy_port/"
declare -x NO_PROXY="localhost,127.0.0.0/8,::1"
declare -x all_proxy="socks://$socks_proxy_host:$socks_proxy_port/"
declare -x ftp_proxy="http://$http_proxy_host:$http_proxy_port/"
declare -x http_proxy="http://$http_proxy_host:$http_proxy_port/"
declare -x https_proxy="http://$http_proxy_host:$http_proxy_port/"
declare -x no_proxy="localhost,127.0.0.0/8,::1"
which dconf && (
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
