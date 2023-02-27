#!/bin/bash

pact-broker record-deployment \
    --pacticipant Product \
    --environment=test \
    --version=$1 \
    --broker-base-url=http://localhost:9292 \
    --broker-username=pactbroker \
    --broker-password=pactbroker \