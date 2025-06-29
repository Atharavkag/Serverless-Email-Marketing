# Setup Instructions for TechTide

**TechTide** is a serverless email marketing application that sends weekly newsletters to subscribers. This guide provides detailed steps to set up and deploy the application on AWS, ensuring a smooth deployment process.

---

## Prerequisites

Before starting, ensure you have the following:

- **AWS Account**: With permissions for Lambda, SES, S3, and CloudFormation.
- **AWS CLI**: Install via `pip install awscli` and configure with `aws configure`.
- **Python**: Version 3.8 or higher.
- **Git**: For cloning the repository.
- **Text Editor**: VS Code, PyCharm, or any editor for modifying files.
- **S3 Assets**: Placeholder images for `assets/` (e.g., `logo.png`, `twitter-icon.png`).

---

## Setup Steps

### 1. Clone the Repository

```bash
git clone https://github.com/Atharavkag/TechTide.git
cd TechTide
pip install -r requirements.txt
aws configure
bash scripts/setup.sh
aws s3 cp assets/ s3://email-marketing01/assets/ --recursive
bash scripts/deploy.sh
Lambda > Functions > TechTideEmailSender > Configuration > Environment Variables
bash scripts/test_email.sh
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": ["s3:PutObject", "s3:GetObject", "s3:CreateBucket"],
      "Resource": "arn:aws:s3:::email-marketing01/*"
    },
    {
      "Effect": "Allow",
      "Action": ["ses:SendEmail", "ses:SendRawEmail", "ses:VerifyEmailIdentity"],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": ["lambda:CreateFunction", "lambda:UpdateFunctionCode", "lambda:InvokeFunction"],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": ["cloudformation:CreateStack", "cloudformation:UpdateStack", "cloudformation:DescribeStacks"],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": ["iam:PassRole", "iam:CreateRole", "iam:PutRolePolicy"],
      "Resource": "*"
    }
  ]
}
