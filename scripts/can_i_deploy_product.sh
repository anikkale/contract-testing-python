#!/bin/bash
# Spinning up the consumer application
echo "Can-i-Deploy Cart to Test"

pact-broker can-i-deploy \
    --pacticipant=Product \
    --version=$1 \
    --to-environment=$2 \
    --broker-base-url=http://localhost:9292 \
    --broker-username=pactbroker \
    --broker-password=pactbroker \
