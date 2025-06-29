import unittest
from lambda.lambda_function import lambda_handler

class TestLambda(unittest.TestCase):
    def test_lambda_handler(self):
        event = {"test": True}
        context = {}
        response = lambda_handler(event, context)
        self.assertIsNone(response) 

if __name__ == '__main__':
    unittest.main()
