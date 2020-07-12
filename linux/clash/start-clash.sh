#!/bin/bash
echo start clash...
if [ $"x$USER" != "xroot" ]
then
    echo need root...
    exit 1
fi
profile=/etc/clash
TIME=`date '+%Y-%m-%dT%H:%M:%S'`
BAK="config.yaml.bak${TIME}"
DEFAULT=config.yaml
BIN="/usr/bin/clash"
export user=${user:=aoeiuv}
export http_proxy_host=${http_proxy_host:=127.0.0.1}
export socks_proxy_host=${socks_proxy_host:=127.0.0.1}
export http_proxy_port=${http_proxy_port:=1082}
export socks_proxy_port=${socks_proxy_port:=1081}

proxy() {
    echo setup proxy...
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
}
start() {
    echo start...
    proxy
    which dconf && sudo -u $user ./system-proxy.sh
    sudo -u nobody $BIN -d $profile
}

cd /etc/clash
url=$(cat subscribe)
if [ "x$url" == "x" ]
then
    echo no subscribe...
    start
    exit
else
    echo updating...
fi
curl --noproxy "*" -L -o $BAK $url
if [ "$?" != 0 ]
then
    echo download failed...
    start
    exit
fi
sed -is '/^\S*port:/d' $BAK
sed -is '/^allow-lan:/d' $BAK
ex $BAK <<EOF
1 i
mixed-port: ${socks_proxy_port}
port: ${http_proxy_port}
socks-port: 11181
allow-lan: false
.
wq
EOF
diff $DEFAULT $BAK
if [ "$?" != 0 ]
then
    echo updated...
    mv $BAK $DEFAULT
else
    echo no update...
    rm $BAK
fi
start
