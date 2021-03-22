#!/bin/bash
echo update clash subscribe...
profile=$(dirname $0)
if [ ! -w $profile ]
then
    echo permission denied: $profile
    exit
fi
TIME=`date +'%Y%m%dT%H%M%S'`
BAK="config.yaml.bak${TIME}"
DEFAULT=config.yaml
SECRET_FILE=$profile/secret
if test -r $SECRET_FILE
then
    SECRET=$(cat $SECRET_FILE)
else
    SECRET=$(dd if=/dev/urandom bs=1 count=12 2>/dev/null|base64)
    echo generate random secret at $SECRET_FILE
    echo $SECRET > $SECRET_FILE
    chmod 600 $SECRET_FILE
fi
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
    read -p "input subscribe url: " url
fi
if [ "x$url" == "x" ]
then
    echo no subscribe url file...
    exit
else
    echo $url > subscribe
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
sed -i '/^external-controller:/d' $BAK
sed -i '/^secret:/d' $BAK
ex $BAK <<EOF
1 i
mixed-port: ${socks_proxy_port}
port: ${http_proxy_port}
socks-port: 11181
allow-lan: false
external-controller: ':9090'
secret: '$SECRET'
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
test -x $profile/refresh.sh && $profile/refresh.sh
