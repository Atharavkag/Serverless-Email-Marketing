#!/bin/bash
set -e

# Package Lambda function
cd lambda
pip install -r requirements.txt -t .
zip -r ../lambda.zip .
cd ..

# Deploy to AWS
aws lambda update-function-code --function-name TechTideEmailSender --zip-file fileb://lambda.zip
aws s3 cp templates/ s3://email-marketing01/templates/ --recursive
aws s3 cp styles/ s3://email-marketing01/styles/ --recursive
aws s3 cp assets/ s3://email-marketing01/assets/ --recursive
aws cloudformation deploy --template-file infrastructure/cloudformation.yaml --stack-name TechTideStack --capabilities CAPABILITY_IAM
echo "Deployment complete"
