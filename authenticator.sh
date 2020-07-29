#!/bin/bash

# Get your API key from https://my.selectel.ru/profile/apikeys
API_KEY="[PLACE_YOUR-API-KEY_HERE]"
API_URL="https://api.selectel.ru/domains/v1"


# Get top domain
DOMAIN=$(awk '{n=split($1, a, "."); printf("%s.%s", a[n-1], a[n])}' <<< $CERTBOT_DOMAIN);


# Get the Selectel zone id
ZONE_ID=$(curl -s -X GET "$API_URL/$DOMAIN" \
    -H    "X-Token: $API_KEY" \
    -H    "Content-Type: application/json" \
    | python -c "import sys,json;print(json.load(sys.stdin)['id'])")


# Create TXT record
CREATE_DOMAIN="_acme-challenge.$CERTBOT_DOMAIN"
RECORD_ID=$(curl -s -X POST "$API_URL/$ZONE_ID/records/" \
    -H "X-Token: $API_KEY" \
    -H "Content-Type: application/json" \
    --data '{"type":"TXT","name":"'"$CREATE_DOMAIN"'","content":"'"$CERTBOT_VALIDATION"'","ttl":120}' \
             | python -c "import sys,json;print(json.load(sys.stdin)['id'])")


# Save info for cleanup
if [ ! -d "/tmp/CERTBOT_$CERTBOT_DOMAIN" ];then
        mkdir -m 0700 "/tmp/CERTBOT_$CERTBOT_DOMAIN"
fi
echo $ZONE_ID > "/tmp/CERTBOT_$CERTBOT_DOMAIN/ZONE_ID"
echo $RECORD_ID > "/tmp/CERTBOT_$CERTBOT_DOMAIN/RECORD_ID"

# Sleep to make sure the change has time to propagate over to DNS
sleep 25
