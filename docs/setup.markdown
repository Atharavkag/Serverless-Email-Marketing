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

Clone the *TechTide* repository to your local machine:

```bash
git clone https://github.com/Atharavkag/TechTide.git
cd TechTide
```

> **Tip**: Ensure you have Git installed (`git --version`). If you encounter issues, see [Troubleshooting](#troubleshooting).

### 2. Install Dependencies

Install the required Python packages for local development:

```bash
pip install -r requirements.txt
```

This installs `boto3`, `requests`, and `pytest` as specified in `requirements.txt`.

### 3. Configure AWS CLI

Set up your AWS credentials and region:

```bash
aws configure
```

Provide:
- **AWS Access Key ID**: Your AWS access key.
- **AWS Secret Access Key**: Your AWS secret key.
- **Default Region**: `us-east-1` (or your preferred region).
- **Output Format**: `json`.

> **Note**: Ensure your AWS user has permissions for Lambda, SES, S3, and CloudFormation. See [IAM Permissions](#iam-permissions) for details.

### 4. Configure AWS Resources

Run the setup script to create the S3 bucket and verify the SES email address:

```bash
bash scripts/setup.sh
```

This script:
- Creates the S3 bucket `email-marketing01`.
- Initiates verification for the source email (`your-email@gmail.com`).

**Post-Setup**:
- Check your email inbox for a verification link from SES.
- Click the link to verify the email in the AWS SES console.

> **Warning**: Emails cannot be sent until the source email is verified.

### 5. Upload Assets

Create placeholder images for `assets/` (e.g., `logo.png`, `twitter-icon.png`, `linkedin-icon.png`, `github-icon.png`) using tools like [Canva](https://www.canva.com) or [Figma](https://www.figma.com).

Upload to S3 manually or via `scripts/deploy.sh`:

```bash
aws s3 cp assets/ s3://email-marketing01/assets/ --recursive
```

### 6. Deploy the Application

Deploy the Lambda function, S3 assets, and CloudFormation stack:

```bash
bash scripts/deploy.sh
```

This script:
- Packages the Lambda function (`lambda/lambda_function.py`) and dependencies into `lambda.zip`.
- Uploads `templates/`, `styles/`, and `assets/` to `s3://email-marketing01/`.
- Deploys the CloudFormation stack (`infrastructure/cloudformation.yaml`) with the stack name `TechTideStack`.

### 7. Configure Lambda Environment Variables

In the AWS Lambda console, navigate to the `TechTideEmailSender` function and set the following environment variables:

| **Key**           | **Value**                     | **Description**                          |
|-------------------|-------------------------------|------------------------------------------|
| `BUCKET_NAME`     | `email-marketing01`           | S3 bucket for templates and data.        |
| `SOURCE_EMAIL`    | `your-email@gmail.com`        | Verified SES email address.              |

**Steps**:
1. Go to AWS Lambda > Functions > `TechTideEmailSender` > Configuration > Environment variables.
2. Add the key-value pairs above.
3. Save changes.

---

## Testing the Application

### Send a Test Email

Use the test script to send an email to the SES Mailbox Simulator:

```bash
bash scripts/test_email.sh
```

This sends an email to `success@simulator.amazonses.com` using `templates/template1.html`.

### Manual Testing

1. In the AWS Lambda console, select `TechTideEmailSender`.
2. Create a test event using `lambda/tests/test_event.json`.
3. Run the test and check CloudWatch logs for results.

### Verify Deployment

- **CloudWatch Logs**: Check `/aws/lambda/TechTideEmailSender` for execution logs.
- **S3 Bucket**: Verify that `templates/`, `styles/`, `assets/`, and `sample_data/contact.csv` are uploaded to `s3://email-marketing01/`.
- **SES**: Confirm emails are sent to the simulator address without errors.

---

## IAM Permissions

Ensure your AWS user or role has the following permissions:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:PutObject",
        "s3:GetObject",
        "s3:CreateBucket"
      ],
      "Resource": "arn:aws:s3:::email-marketing01/*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "ses:SendEmail",
        "ses:SendRawEmail",
        "ses:VerifyEmailIdentity"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "lambda:CreateFunction",
        "lambda:UpdateFunctionCode",
        "lambda:InvokeFunction"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "cloudformation:CreateStack",
        "cloudformation:UpdateStack",
        "cloudformation:DescribeStacks"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "iam:PassRole",
        "iam:CreateRole",
        "iam:PutRolePolicy"
      ],
      "Resource": "*"
    }
  ]
}
```

---

## Troubleshooting

| **Issue**                        | **Solution**                                                                 |
|----------------------------------|-----------------------------------------------------------------------------|
| **S3 Access Denied**             | Verify the Lambda role (`infrastructure/role-policy.json`) has `s3:GetObject`. |
| **SES Email Not Sent**           | Ensure the source email is verified in SES and `SOURCE_EMAIL` is set.       |
| **Lambda Timeout**               | Increase the Lambda timeout (default: 60 seconds) in the console.           |
| **CloudFormation Failure**       | Check stack events in the CloudFormation console for detailed errors.       |

> **Tip**: Enable detailed CloudWatch logging in `lambda/lambda_function.py` for debugging.

---

## Next Steps

- Upload real subscriber data to `sample_data/contact.csv` (ensure no sensitive data).
- Create and upload images to `assets/` for the email template.
- Explore [contributing.md](contributing.md) to add features or improvements.

For contribution guidelines, see [contributing.md](contributing.md).