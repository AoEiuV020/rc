#!/bin/bash
set -e
oldpwd=$PWD
cd $(dirname $0)
zoneId=$1
domain=$2
value=$3
if test -z "$zoneId"; then
  echo zoneId empty
  exit 1
fi
if test -z "$domain"; then
  echo domain empty
  exit 2
fi
if test -z "value"; then
  echo value empty
  exit 3
fi
export keyScript=${keyScript:-$PWD/../key.sh}
. $keyScript

echo key=$CLOUD_FLARE_TOKEN >&2
subDomain=_acme-challenge
echo curl -s -X POST "https://api.cloudflare.com/client/v4/zones/$zoneId/dns_records" -H "Authorization: Bearer $CLOUD_FLARE_TOKEN" -H "Content-Type: application/json" --data "{\"type\":\"TXT\",\"name\":\"$subDomain.$domain\",\"content\":\"$value\"}" >&2
curl -s -X POST "https://api.cloudflare.com/client/v4/zones/$zoneId/dns_records" -H "Authorization: Bearer $CLOUD_FLARE_TOKEN" -H "Content-Type: application/json" --data "{\"type\":\"TXT\",\"name\":\"$subDomain.$domain\",\"content\":\"$value\"}"
