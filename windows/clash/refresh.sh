#!/bin/bash
profile="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
profile=$(echo $profile|sed 's/^\/\([a-zA-z]\)\//\1:\//')
SECRET_FILE=$profile/secret
if test -r $SECRET_FILE
then
    SECRET=$(cat $SECRET_FILE)
else
    SECRET=$(dd if=/dev/urandom bs=1 count=12 2>/dev/null|base64)
    echo generate random secret at $SECRET_FILE
    echo $SECRET > $SECRET_FILE
fi
data=$(cat <<EOF
{
  "path": "$profile/config.yaml",
  "force": "true"
}
EOF
)
echo refresh $data
curl -X PUT --data-raw "$data" 'http://127.0.0.1:9090/configs' -H "Authorization: Bearer $SECRET"
