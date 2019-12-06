#!/bin/bash
set -e
oldpwd=$PWD
cd $(dirname $0)
zoneId=$1
domain=$2
subDomain=$3
if test -z "$zoneId"; then
  echo zoneId empty
  exit 1
fi
if test -z "$domain"; then
  echo domain empty
  exit 2
fi
if test -z "$subDomain"; then
  echo subDomain empty
  exit 3
fi
export keyScript=${keyScript:-$PWD/../key.sh}
. $keyScript

echo key=$CLOUD_FLARE_TOKEN >&2
echo curl -X GET "https://api.cloudflare.com/client/v4/zones/$zoneId/dns_records?name=$subDomain.$domain&page=1&per_page=20&order=type&direction=desc&match=all" -H "Authorization: Bearer $CLOUD_FLARE_TOKEN" -H "Content-Type: application/json" >&2
curl -s -X GET "https://api.cloudflare.com/client/v4/zones/$zoneId/dns_records?name=$subDomain.$domain&page=1&per_page=20&order=type&direction=desc&match=all" -H "Authorization: Bearer $CLOUD_FLARE_TOKEN" -H "Content-Type: application/json"
