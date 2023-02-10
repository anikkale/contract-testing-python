#!/bin/bash
set -o pipefail

# Wait a little in case FastAPI isn't quite ready
sleep 1

echo "Validating contract against Pact Broker"


pact-verifier --provider-base-url=http://localhost:8000 \
--provider-app-version latest \
--pact-url="http://127.0.0.1/pacts/provider/Product/consumer/Cart/latest" \
--pact-broker-username pactbroker \
--pact-broker-password pactbroker \
--publish-verification-results \
