import os.path
import logging
import sys

sys.path.append(os.path.join(os.path.dirname(__file__), '..'))

import atexit
import unittest
import requests
from pact import Consumer, Provider

log = logging.getLogger(__name__)
logging.basicConfig(level=logging.DEBUG)

pact = Consumer('Cart').has_pact_with(
        Provider('Product'),
        pact_dir='./pact/pacts',
        log_dir='./log',
        port=1234,
        host_name='localhost',
        publish_to_broker=True,
        broker_base_url = 'http://localhost:80',
        broker_username='pactbroker',
        broker_password='pactbroker',
        )

pact.start_service()
atexit.register(pact.stop_service)

# PACT_FILE="./pact/pacts/cart-product.json"

class GetProductInfoContract(unittest.TestCase):


    def test_get_product_info(self):
        
        mock_host='http://localhost:1234' # this is the mock service just like <external services>

        payload = {
            "product_id": 1,
            "quantity": 1,
        }
        expected = {
            "product_id": 1,
            "quantity": 1,
            "name": "Microphone",
            "description": "Used for podcasting",
            "final_price": 100,
            "stock_status": "ADDED_TO_BASKET"
        }

        (pact
            .given('Product with id 1 is created and have price')
            .upon_receiving('a request for product with id 1')
            .with_request(
                method='POST', 
                path='/add-to-cart',
                body=payload)
            .will_respond_with(201, body=expected)
            )

        pact.setup()
        with pact:
            result = requests.post(f'{mock_host}/add-to-cart', json=payload)
        
        self.assertEqual(result.json(), expected)
        self.assertEqual(result.status_code, 201)
        pact.verify()