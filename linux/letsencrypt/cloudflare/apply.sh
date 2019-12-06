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

zoneId=$(./queryZone.sh $domain)
echo zoneId=$zoneId >&2
subDomain=_acme-challenge
# 添加记录，
echo ./add.sh $zoneId $domain $value >&2
./add.sh $zoneId $domain $value

