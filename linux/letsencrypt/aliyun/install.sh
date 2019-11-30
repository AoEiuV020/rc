#!/bin/sh
set -e
if test ! -w /usr/local/bin/; then
    echo "require write permission of /usr/local/bin"
    exit 1
fi
oldpwd=$PWD
tmpdir=$(mktemp -u)
mkdir $tmpdir
cd $tmpdir
curl -o aliyuncli.tgz 'https://aliyuncli.alicdn.com/aliyun-cli-linux-3.0.16-amd64.tgz?spm=a2c4g.11186623.2.12.6a6b5598E6I8p2&file=aliyun-cli-linux-3.0.16-amd64.tgz'
tar -zxf aliyuncli.tgz 
mv aliyun /usr/local/bin/
cd $oldpwd
rm -rf $tmpdir
