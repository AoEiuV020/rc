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
# 添加记录，
echo ./add.sh $domain $value >&2
./add.sh $domain $value

