#!/bin/bash

pact-broker record-deployment \
    --pacticipant Cart \
    --environment=test \
    --version=$1 \
    --broker-base-url=http://localhost:80 \
    --broker-username=pactbroker \
    --broker-password=pactbroker \