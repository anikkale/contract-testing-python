from pact import Verifier


PACT_URL = "./pacts/cart-product.json"
verifier = Verifier(provider='UserService',
                    provider_base_url=PACT_URL)

# Using a local pact file

success, logs = verifier.verify_pacts(PACT_URL)
assert success == 0

# Using a pact broker

success, logs = verifier.verify_with_broker(
    broker_base_url = 'http://localhost:80',
    broker_username='pactbroker',
    broker_password='pactbroker',
    publish_version=APPLICATION_VERSION,
    publish_verification_results=True,
    verbose=True,
    provider_version_branch=PROVIDER_BRANCH,
    enable_pending=True,
)
assert success == 0