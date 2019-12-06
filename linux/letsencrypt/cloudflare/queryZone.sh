#!/bin/bash
set -e
oldpwd=$PWD
cd $(dirname $0)
domain=$1
if test -z "$domain"; then
  echo domain empty
  exit 1
fi
export keyScript=${keyScript:-$PWD/../key.sh}
. $keyScript

echo key=$CLOUD_FLARE_TOKEN >&2
echo 'curl -s "https://api.cloudflare.com/client/v4/zones?name=$domain&status=active&page=1&per_page=20&order=status&direction=desc&match=all" -H "Authorization: Bearer $CLOUD_FLARE_TOKEN" -H "Content-Type: application/json" | jq -r .result[0].id' >&2
curl -s "https://api.cloudflare.com/client/v4/zones?name=$domain&status=active&page=1&per_page=20&order=status&direction=desc&match=all" -H "Authorization: Bearer $CLOUD_FLARE_TOKEN" -H "Content-Type: application/json" | jq -r .result[0].id
