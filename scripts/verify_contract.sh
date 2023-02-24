#!/bin/bash
set -o pipefail

echo "Validating contract against Pact Broker"
pact-verifier --provider-base-url=http://localhost:8000 \
--provider-app-version $1 \
--pact-url="http://localhost/pacts/provider/Product/consumer/Cart/version/latest" \
--pact-broker-username pactbroker \
--pact-broker-password pactbroker \
--publish-verification-results \
