#!/bin/bash
set -e
oldpwd=$PWD
cd $(dirname $0)
domain=$1
value=$2
export keyScript=${keyScript:-$PWD/../key.sh}

if test -z "$domain"; then
  echo domain empty
  exit 1
fi
if test -z "$value"; then
  echo value empty
  exit 2
fi

subDomain=_acme-challenge
# 先删除之前设置的记录，
idList=($(
  ./query.sh $domain $subDomain |
    jq -r '.data.records|.[].id'
))
for id in ${idList[*]}; do
  echo ./delete.sh $domain $id
  ./delete.sh $domain $id
done

# 添加记录，
echo ./add.sh $domain $value
./add.sh $domain $value
