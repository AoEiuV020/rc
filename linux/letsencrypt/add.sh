#!/bin/sh
# 添加域名对应dns的服务商，
# 阿里云: aliyun
# 腾讯云: tencent
# namecheap: namecheap
set -e
oldpwd=$PWD
tmpdir=$(mktemp -u)
mkdir $tmpdir
cd $(dirname $0)
domain=$1
value=$2

if test -z "$domain"; then
    echo domain empty
    exit 1
fi
if test -z "$value"; then
    echo value empty
    exit 2
fi

domainFile=domain.json
if test ! -e $domainFile; then
    echo '{}' > $domainFile
fi
jq ".+{\"$domain\":\"$value\"}" $domainFile > $domainFile.bak
mv -f $domainFile.bak $domainFile

cd $oldpwd
rm -rf $tmpdir
