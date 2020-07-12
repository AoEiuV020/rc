#!/bin/bash
echo setup system proxy...
export http_proxy_host=${http_proxy_host:=127.0.0.1}
export socks_proxy_host=${socks_proxy_host:=127.0.0.1}
export http_proxy_port=${http_proxy_port:=1082}
export socks_proxy_port=${socks_proxy_port:=1081}
HOME=$(eval echo ~$USER)
echo $DISPLAY
dbus-launch dconf write /system/proxy/http/host "'$http_proxy_host'"
dbus-launch dconf write /system/proxy/http/port "$http_proxy_port"
dbus-launch dconf write /system/proxy/https/host "'$http_proxy_host'"
dbus-launch dconf write /system/proxy/https/port "$http_proxy_port"
dbus-launch dconf write /system/proxy/ftp/host "'$http_proxy_host'"
dbus-launch dconf write /system/proxy/ftp/port "$http_proxy_port"
dbus-launch dconf write /system/proxy/socks/host "'$socks_proxy_host'"
dbus-launch dconf write /system/proxy/socks/port "$socks_proxy_port"
dbus-launch dconf write /system/proxy/mode "'manual'"
