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
