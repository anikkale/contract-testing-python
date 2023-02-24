#!/bin/bash
# Spinning up the consumer application
echo "Can-i-Deploy Cart to Prod"

pact-broker can-i-deploy \
    --pacticipant=Cart \
    --version=$1 \
    --to-environment=test \
    --broker-base-url=http://localhost:80 \
    --broker-username=pactbroker \
    --broker-password=pactbroker \
