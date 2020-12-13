#!/bin/sh

zone_ID="01234567890abcedf"
record_ID="01234567890abcedf"
X_Auth_Email="mail@example.com"
X_Auth_Key="01234567890abcedf"
dns_name="www.example.com"

IP_address="$(curl -s checkip.amazonaws.com)"
if [ "$?" -ne 0 ]; then
    echo "Could not get public IP address on Amazon AWS. Exiting..." && exit 1
fi

json_result="$(curl -s -X PUT "https://api.cloudflare.com/client/v4/zones/$zone_ID/dns_records/$record_ID" \
     -H "Content-Type:application/json" \
     -H "X-Auth-Email:$X_Auth_Email" \
     -H "X-Auth-Key:$X_Auth_Key" \
     --data '{"type":"A","name":"'"$dns_name"'","content":"'"$IP_address"'","ttl":1,"proxied":true}')"
if [ "$?" -ne 0 ]; then
    echo "Could not send request to Cloud Flare API. Exiting..." && exit 1
fi

echo "$json_result" | grep -q '\"success\"\:true'
if [ "$?" -ne 0 ]; then
    echo "Cloud Flare API returned an error:\n\n$json_result" && exit 1
fi

echo "Successfully pointed dns name \"$dns_name\" to IP \"$IP_address\"."
