import os
from pact import Verifier

# const broker_opts={
#         "broker_username": PACT_BROKER_USERNAME,
#         "broker_password": PACT_BROKER_PASSWORD,
#         "broker_url": PACT_BROKER_URL,
#         "publish_version": "3",
#         "publish_verification_results": True,
#     }
verifier = Verifier(provider='Product',
                    provider_base_url="http://localhost:8000",)

success, logs = verifier.verify_with_broker(
                    broker_url="http://localhost:9292",
                    consumer_version_selectors=[
                    {"branch": "main"}, # (recommended) - Returns the pacts for consumers configured mainBranch property
                    {"latest": True}, # (recommended) - Returns the pacts for all versions of the consumer that are currently deployed or released and currently supported in any environment.
                    {"deployedOrReleased": True},
                    {"environment": "test"}, #  Normally, this would not be needed, Any versions currently deployed or released and supported in the specified environment.
                    {"environment": "production"}, #  Normally, this would not be needed, Any versions currently deployed or released and supported in the specified environment.
    ],
                    broker_username='pactbroker',
                    broker_password='pactbroker',
                    publish_version=os.getenv('version'),
                    provider_version_branch='main',
                    publish_verification_results=True,
)

assert success == 0
