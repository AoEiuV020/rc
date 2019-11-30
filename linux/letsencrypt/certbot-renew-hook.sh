#!/bin/bash
set -e
oldpwd=$PWD
cd $(dirname $0)
domain=$CERTBOT_DOMAIN
value=$CERTBOT_VALIDATION
export keyScript=${1:-$PWD/key.sh}
if test -z "$domain"; then
  echo domain empty
  exit 1
fi
if test -z "$value"; then
  echo value empty
  exit 2
fi
if test ! -e "$keyScript"; then
  echo $keyScript not found
  exit 3
fi
if test ! -r "$keyScript"; then
  echo $keyScript can not read
  exit 4
fi

dnsServer=$(jq -r ".\"$domain\"" domain.json)
if test ! -d "$dnsServer"; then
  echo "$domain => $dnsServer not support"
  exit 5
fi
echo $PWD/$dnsServer/apply.sh $domain $value
$PWD/$dnsServer/apply.sh $domain $value
# 事后删除记录，
# 搞孤儿进程，否则certbot会等子进制结束才继续，
echo bash -c "{ nohup sleep 600 >/dev/null 2>&1 ;$PWD/$dnsServer/reset.sh $domain $value & } &"
bash -c "{ nohup sleep 600 >/dev/null 2>&1 ;$PWD/$dnsServer/reset.sh $domain $value & } &"
# 等生效，添加记录很快生效的，
echo sleep 10
sleep 10
