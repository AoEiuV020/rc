#!/bin/bash
echo update clash subscribe...
profile=$(dirname $0)
if [ ! -w $profile ]
then
    echo permission denied: $profile
    exit
fi
TIME=`date '+%Y-%m-%dT%H:%M:%S'`
BAK="config.yaml.bak${TIME}"
DEFAULT=config.yaml
export user=${user:=aoeiuv}
export http_proxy_host=${http_proxy_host:=127.0.0.1}
export socks_proxy_host=${socks_proxy_host:=127.0.0.1}
export http_proxy_port=${http_proxy_port:=1082}
export socks_proxy_port=${socks_proxy_port:=1081}

cd $profile
url=$1
if [ "x$url" == "x" ]
then
    echo no subscribe url argument...
    if [ -r subscribe ]
    then
        url=$(cat subscribe)
    fi
fi
if [ "x$url" == "x" ]
then
    echo no subscribe url file...
    exit
fi
echo updating $url
curl --noproxy "*" -L -o $BAK $url
if [ "$?" != 0 ]
then
    echo download failed...
    exit
fi
sed -i '/^\S*port:/d' $BAK
sed -i '/^allow-lan:/d' $BAK
ex $BAK <<EOF
1 i
mixed-port: ${socks_proxy_port}
port: ${http_proxy_port}
socks-port: 11181
allow-lan: false
.
wq
EOF
diff $DEFAULT $BAK &>/dev/null
if [ "$?" != 0 ]
then
    echo updated...
    mv $BAK $DEFAULT
else
    echo no update...
    rm $BAK
fi
