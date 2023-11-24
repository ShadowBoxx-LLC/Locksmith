#!/bin/bash

API_URL="https://your-api-url.com"
API_TOKEN="your_api_token"

fetch_keys() {
    local username=$1
    curl -s -H "Authorization: $API_TOKEN" "$API_URL/user/$username/keys" | jq -r '.keys[]'
}

create_user_if_not_exists() {
    local username=$1
    if ! id -u $username > /dev/null 2>&1; then
        sudo adduser --disabled-password --gecos "" $username
    fi
}

while true; do
    for username in $(curl -s -H "Authorization: $API_TOKEN" "$API_URL/users" | jq -r '.[]'); do
        create_user_if_not_exists $username
        fetch_keys $username > ~$username/.ssh/authorized_keys
    done
    sleep 5
done