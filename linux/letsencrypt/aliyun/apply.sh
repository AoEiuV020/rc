#!/bin/bash
set -e
oldpwd=$PWD
cd $(dirname $0)
domain=$1
value=$2
#dryrun='--dryrun'

if test -z "$domain"; then
  echo domain empty
  exit 1
fi
if test -z "$value"; then
  echo value empty
  exit 2
fi

subDomain=_acme-challenge

# 添加记录，
echo aliyun alidns AddDomainRecord --DomainName $domain --RR $subDomain --Type TXT --Value $value $dryrun
aliyun alidns AddDomainRecord --DomainName $domain --RR $subDomain --Type TXT --Value $value $dryrun

# 事后删除记录，
sleep 3600 && ./reset.sh $@ &
