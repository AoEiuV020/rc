#!/bin/bash
set -e
oldpwd=$PWD
tmpdir=$(mktemp -u)
mkdir -p $tmpdir
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

subDomain=_acme-challenge.$domain
# 先删除之前设置的记录，
idList=($(aliyun alidns DescribeSubDomainRecords --SubDomain $subDomain \
    |jq .DomainRecords.Record \
    |jq -r '.[].RecordId' \
    ))
for id in ${idList[*]}; do
    echo aliyun alidns DeleteDomainRecord  --RecordId $id $dryrun
    aliyun alidns DeleteDomainRecord  --RecordId $id $dryrun
done

# 添加记录，
echo aliyun alidns AddDomainRecord --DomainName $domain --RR _acme-challenge --Type TXT --Value $value $dryrun
aliyun alidns AddDomainRecord --DomainName $domain --RR _acme-challenge --Type TXT --Value $value $dryrun

cd $oldpwd
rm -rf $tmpdir
