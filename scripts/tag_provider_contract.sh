#!/bin/bash

pact-broker record-deployment \
    --pacticipant Product \
    --environment=$2 \
    --version=$1 \
    --broker-base-url=http://localhost:9292 \
    --broker-username=pactbroker \
    --broker-password=pactbroker \