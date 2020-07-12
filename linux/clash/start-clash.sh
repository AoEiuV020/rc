#!/bin/bash
# save pid file


profile=/etc/clash
TIME=`date '+%Y-%m-%dT%H:%M:%S'`
BAK="config.yaml.bak${TIME}"
DEFAULT=config.yaml
BIN="/usr/bin/clash"
start="$BIN -d $profile"

cd /etc/clash
url=$(cat subscribe)
if [ "x$url" == "x" ]
then
    echo no subscribe...
    . proxy.sh
    $start
    exit
else
    echo updating...
fi
curl --noproxy "*" -L -o $BAK $url
if [ "$?" != 0 ]
then
    echo download failed...
    . proxy.sh
    $start
    exit
fi
. proxy.sh
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
$start
