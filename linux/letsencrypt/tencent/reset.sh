#!/bin/bash
set -e
oldpwd=$PWD
cd $(dirname $0)
domain=$1
export keyScript=${keyScript:-$PWD/../key.sh}

if test -z "$domain"; then
  echo domain empty
  exit 1
fi

subDomain=_acme-challenge
# 删除之前设置的记录，
idList=($(
  ./query.sh $domain $subDomain |
    jq -r '.data.records|.[].id'
))
for id in ${idList[*]}; do
  echo ./delete.sh $domain $id >&2
  ./delete.sh $domain $id
done

