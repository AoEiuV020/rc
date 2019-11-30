#!/bin/bash
set -e
oldpwd=$PWD
cd $(dirname $0)
export keyScript=${1:-$PWD/key.sh}
if test ! -e "$keyScript"; then
  echo $keyScript not found
  exit 3
fi
if test ! -r "$keyScript"; then
  echo $keyScript can not read
  exit 4
fi

# 删除记录，
domainList=($(jq -r 'keys|.[]' domain.json))
for domain in ${domainList[*]}; do
    dnsServer=$(jq -r ".\"$domain\"" domain.json)
    echo $PWD/$dnsServer/reset.sh $domain
    $PWD/$dnsServer/reset.sh $domain
done
