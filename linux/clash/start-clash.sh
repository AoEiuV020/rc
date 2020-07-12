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
    $start
    exit
else
    echo updating...
fi
curl --noproxy "*" -L -o $BAK $url
if [ "$?" != 0 ]
then
    echo download failed...
    $start
    exit
fi
sed -is '/^\S*port:/d' $BAK
sed -is '/^allow-lan:/d' $BAK
sed -is '1i\
mixed-port: 1081\
port: 1082\
socks-port: 11181\
allow-lan: false' $BAK
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
