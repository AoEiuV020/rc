#!/bin/bash
set -e
oldpwd=$PWD
cd $(dirname $0)
domain=$CERTBOT_DOMAIN
value=$CERTBOT_VALIDATION
keyScript=${1:-$PWD/key.sh}
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
echo $PWD/$dnsServer/add.sh $domain $value $keyScript
$PWD/$dnsServer/add.sh $domain $value $keyScript

