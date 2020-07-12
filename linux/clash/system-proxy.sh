#!/bin/bash
echo setup system proxy...
export http_proxy_host=${http_proxy_host:=127.0.0.1}
export socks_proxy_host=${socks_proxy_host:=127.0.0.1}
export http_proxy_port=${http_proxy_port:=1082}
export socks_proxy_port=${socks_proxy_port:=1081}
HOME=$(eval echo ~$USER)
export DISPLAY=:0
export XDG_RUNTIME_DIR="/run/user/$UID"
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$UID/bus"
dconf write /system/proxy/http/host "'$http_proxy_host'"
dconf write /system/proxy/http/port "$http_proxy_port"
dconf write /system/proxy/https/host "'$http_proxy_host'"
dconf write /system/proxy/https/port "$http_proxy_port"
dconf write /system/proxy/ftp/host "'$http_proxy_host'"
dconf write /system/proxy/ftp/port "$http_proxy_port"
dconf write /system/proxy/socks/host "'$socks_proxy_host'"
dconf write /system/proxy/socks/port "$socks_proxy_port"
dconf write /system/proxy/mode "'manual'"
