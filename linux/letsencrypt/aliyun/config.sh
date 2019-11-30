#!/bin/bash
set -e
oldpwd=$PWD
cd $(dirname $0)
export keyScript=${keyScript:-$PWD/../key.sh}
. $keyScript
echo key=$ALIYUN_KEY
echo secret=$ALIYUN_SECRET
aliyun configure set \
  --profile akProfile \
  --mode AK \
  --region cn-hangzhou \
  --access-key-id $ALIYUN_KEY \
  --access-key-secret $ALIYUN_SECRET 
