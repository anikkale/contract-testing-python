#!/bin/bash
set -o pipefail

echo "Validating contract against Pact Broker"
pact-verifier --provider-base-url http://localhost:8000 \
--provider-app-version $1 \
--provider-version-branch main \
--consumer-version-selector {"branch":"main","deployedOrReleased": True,"matchingBranch": True} \
--pact-broker-username pactbroker \
--pact-broker-password pactbroker \
--publish-verification-results \
