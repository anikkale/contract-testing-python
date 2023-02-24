#!/bin/bash
# Spinning up the consumer application
echo "Publishing the contract to pact broker"

pact-broker publish ./pacts \
    --consumer-app-version=$1 \
    --branch=main \
    --broker-base-url=http://localhost:80 \
    --broker-username=pactbroker \
    --broker-password=pactbroker \