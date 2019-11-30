#!/bin/bash
set -e
oldpwd=$PWD
cd $(dirname $0)
domain=$1
#dryrun='--dryrun'

if test -z "$domain"; then
  echo domain empty
  exit 1
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
