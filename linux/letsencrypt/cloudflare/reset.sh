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

echo key=$CLOUD_FLARE_TOKEN >&2
zoneId=$(./queryZone.sh $domain)
subDomain=_acme-challenge
# 删除之前设置的记录，
idList=($(
  ./query.sh $zoneId $domain $subDomain |
    jq -r '.result[].id'
))
for id in ${idList[*]}; do
  echo ./delete.sh $zoneId $domain $id >&2
  ./delete.sh $zoneId $domain $id
done

