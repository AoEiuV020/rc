#!/bin/bash
profile="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
SECRET_FILE=$profile/secret
if test -r $SECRET_FILE
then
    SECRET=$(cat $SECRET_FILE)
else
    SECRET=$(dd if=/dev/urandom bs=1 count=12 2>/dev/null|base64)
    echo generate random secret at $SECRET_FILE
    echo $SECRET > $SECRET_FILE
    chmod 600 $SECRET_FILE
fi
data=$(cat <<EOF
{
  "path": "$profile/config.yaml",
  "force": "true"
}
EOF
)
echo refresh $data
temp_file=$(tempfile)
code=$(curl -s -w '%{http_code}' --noproxy "*" -L -o "$temp_file" -X PUT --data-raw "$data" 'http://127.0.0.1:9090/configs' -H "Authorization: Bearer $SECRET")
result=$(cat $temp_file)
rm $temp_file
if [[ "$code" != 200 && "$code" != 204 ]]
then
    echo refresh failed: $code >&2
    exit  4
fi
