#!/bin/bash
set -e
oldpwd=$PWD
cd $(dirname $0)
domain=$1
subDomain=$2
if test -z "$domain"; then
  echo domain empty
  exit 1
fi
if test -z "$subDomain"; then
  echo subDomain empty
  exit 2
fi
export keyScript=${keyScript:-$PWD/../key.sh}
. $keyScript

tmpdir=$(mktemp -u)
mkdir $tmpdir
trap "{ rm -rf $tmpdir; }" EXIT
cd $tmpdir

echo key=$TENCENT_KEY >&2
valueStr=$(echo {} |
  jq ".+{SecretId:\"$TENCENT_ID\"}" |
  jq ".+{Region:\"ap-guangzhou\"}" |
  jq ".+{Timestamp:\"$(date +%s)\"}" |
  jq ".+{Nonce:\"$(shuf -i 0-99999 -n 1)\"}" |
  jq ".+{SignatureMethod:\"HmacSHA256\"}" |
  jq ".+{Action:\"RecordList\"}" |
  jq ".+{offset:\"0\"}" |
  jq ".+{length:\"20\"}" |
  jq ".+{domain:\"$domain\"}" |
  jq ".+{subDomain:\"$subDomain\"}" |
  jq -S . |
  jq -r 'to_entries|map("\(.key)=\(.value)")|join("&")')
apiDomain="cns.api.qcloud.com"
srcStr="GET$apiDomain/v2/index.php?$valueStr"
echo srcStr=$srcStr >&2

sign=$(echo -n $srcStr | openssl sha256 -hmac $TENCENT_KEY -binary | base64)
# url encode,
sign=${sign//+/%2B}
sign=${sign//\//%2F}
echo sign=$sign >&2

url="https://$apiDomain/v2/index.php?$valueStr&Signature=$sign"
echo curl $url >&2
curl -s $url
