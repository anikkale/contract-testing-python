import os.path
import logging
import sys

from consumer.cart import get_product_info

sys.path.append(os.path.join(os.path.dirname(__file__), '..'))

import atexit
import unittest
import requests
from pact import Consumer, Provider

log = logging.getLogger(__name__)
logging.basicConfig(level=logging.DEBUG)

pact = Consumer('Cart').has_pact_with(
        Provider('Product'),
        pact_dir='./pacts',
        log_dir='./log',
        port=1234,
        host_name='localhost',
        publish_to_broker=False,
        )

pact.start_service()
atexit.register(pact.stop_service)


class GetProductInfoContract(unittest.TestCase):

    def test_get_product_info(self):
        
        mock_host='http://localhost:1234' # this is the mock service just like <external services>

        expected = {
            "name": "Microphone",
            "price": 100,
            "product_id": 1
        }

        (pact
            .given('Product with id 1 is created and have price')
            .upon_receiving('a request for product with id 1')
            .with_request(
                method='GET', 
                path='/product/1')
            .will_respond_with(200, body=expected)
            )

        pact.setup()
        with pact:
            result = get_product_info(mock_host,1)
        
        self.assertEqual(result, expected)
        pact.verify()