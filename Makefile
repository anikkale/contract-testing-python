# Consumer Commands
install:
	#install commands
	pip install --upgrade pip &&\
		pip install -r requirements.txt

run_consumer:
	uvicorn consumer.cart:app --port 8001
	
test_consumer_interaction:
	sh scripts/test_cart_consumer.sh

publish_contract:
	sh scripts/publish_contract.sh ${version}

tag_consumer_contract_as_deployed:
	sh scripts/tag_consumer_contract.sh ${version}

can_i_deploy_cart:
	sh scripts/can_i_deploy_cart.sh ${version} ${env}


# Provider Commands

run_provider:
	uvicorn provider.product:app --port 8000

verify_provider_contract:
	python provider/tests/verify_contract ${version}

tag_provider_contract_as_deployed:
	sh scripts/tag_provider_contract.sh ${version}

can_i_deploy_product:
	sh scripts/can_i_deploy_product.sh ${version} ${env}

test:
	#test
	python -m pytest -vv --cov=mylib --cov=main test_*.py

all: install