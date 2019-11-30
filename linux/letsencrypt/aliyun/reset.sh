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
# 删除之前设置的记录，
idList=($(
  aliyun alidns DescribeSubDomainRecords --SubDomain $subDomain.$domain |
    jq .DomainRecords.Record |
    jq -r '.[].RecordId'
))
for id in ${idList[*]}; do
  echo aliyun alidns DeleteDomainRecord --RecordId $id $dryrun
  aliyun alidns DeleteDomainRecord --RecordId $id $dryrun
done
