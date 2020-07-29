#!/bin/bash

# Get your API key from https://my.selectel.ru/profile/apikeys
API_KEY="[PLACE_YOUR-API-KEY_HERE]"
API_URL="https://api.selectel.ru/domains/v1"


if [ -f "/tmp/CERTBOT_$CERTBOT_DOMAIN/ZONE_ID" ]; then
        ZONE_ID=$(cat "/tmp/CERTBOT_$CERTBOT_DOMAIN/ZONE_ID")
        rm -f "/tmp/CERTBOT_$CERTBOT_DOMAIN/ZONE_ID"
fi


if [ -f "/tmp/CERTBOT_$CERTBOT_DOMAIN/RECORD_ID" ]; then
        RECORD_ID=$(cat "/tmp/CERTBOT_$CERTBOT_DOMAIN/RECORD_ID")
        rm -f "/tmp/CERTBOT_$CERTBOT_DOMAIN/RECORD_ID"
fi


# Remove the challenge TXT record from the zone
if [ -n "${ZONE_ID}" ]; then
    if [ -n "${RECORD_ID}" ]; then
        curl -s -X DELETE "$API_URL/$ZONE_ID/records/$RECORD_ID" \
                -H "X-Token: $API_KEY" \
                -H "Content-Type: application/json"
    fi
fi
