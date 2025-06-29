# TechTide Architecture

**TechTide** is a serverless email marketing application that delivers weekly tech newsletters to subscribers using AWS services. This document provides an in-depth overview of its architecture, components, data flow, and security considerations, designed for developers, architects, and stakeholders.

---

## Overview

TechTide leverages AWS serverless services to ensure scalability, cost-efficiency, and minimal operational overhead. The application processes subscriber data from a CSV file, renders a personalized HTML email template, and sends emails via Amazon SES, triggered weekly by CloudWatch Events.

---

## Key Components

| Component      | AWS Service     | Purpose                                                                 |
|----------------|------------------|-------------------------------------------------------------------------|
| Email Sender   | AWS Lambda       | Executes logic to process subscriber data and send personalized emails |
| Email Delivery | Amazon SES       | Delivers HTML emails to subscribers using a verified source email      |
| Asset Storage  | Amazon S3        | Stores email templates, CSS, subscriber data, and static assets        |
| Scheduler      | CloudWatch Events| Automates weekly Lambda triggers for email sending                     |

---

## Architecture Diagram

> ![TechTide Architecture](https://github.com/Atharavkag/Serverless-Email-Marketing/raw/main/assets/architecture.png)

---

## Lambda Monitoring Metrices

![Alt Text](https://raw.githubusercontent.com/Atharavkag/Serverless-Email-Marketing/main/assets/lambda-metrics-1.png)

![Alt Text](https://raw.githubusercontent.com/Atharavkag/Serverless-Email-Marketing/main/assets/lambda-metrics-2.png)



## Detailed Architecture

### AWS Lambda

**Function Name:** `TechTideEmailSender`  
**Handler:** `lambda_function.lambda_handler`  
**Runtime:** Python 3.8

**Responsibilities:**
- Reads `sample_data/contact.csv` from S3 for subscriber details (`FirstName`, `Email`)
- Fetches `templates/template1.html` and `styles/styles.css` from S3
- Personalizes the email template with subscriber data
- Sends emails via SES

**Environment Variables:**
- `BUCKET_NAME`: `email-marketing01`
- `SOURCE_EMAIL`: Your verified SES email (e.g., `your-email@gmail.com`)

**Timeout:** 60 seconds  
**Logging:** Outputs to CloudWatch Logs for debugging

---

### Amazon SES

**Purpose:** Sends personalized HTML emails to subscribers  
**Configuration:** Defined in `config/ses_config.json` (source email and region)

**Features:**
- Supports HTML emails with inline and external CSS (`styles/styles.css`)
- Requires a verified source email to send emails

**Testing:** Use `scripts/test_email.sh` to send test emails to `success@simulator.amazonses.com`

---

### Amazon S3

**Bucket Name:** `email-marketing01`

**Contents:**
- `templates/template1.html`: Main email template
- `styles/styles.css`: External CSS for email styling
- `assets/`: Images (e.g., `logo.png`, `twitter-icon.png`)
- `sample_data/contact.csv`: Subscriber list

**Access:** Lambda has `s3:GetObject` permissions via `infrastructure/role-policy.json`

---

### CloudWatch Events

**Rule:** Triggers `TechTideEmailSender` every Sunday at 9 AM UTC (`cron(0 9 * * SUN *)`)  
**Purpose:** Automates weekly email delivery without manual intervention  
**Permissions:** Granted via `AWS::Lambda::Permission` in `infrastructure/cloudformation.yaml`

---

## Data Flow

1. **Trigger:** CloudWatch Events invokes the Lambda function weekly  
2. **Data Retrieval:**
   - Lambda fetches `sample_data/contact.csv` from `s3://email-marketing01/`
   - Retrieves `templates/template1.html` and `styles/styles.css`  
3. **Email Personalization:**
   - Replaces placeholders (e.g., `{{FirstName}}`, `{{UnsubscribeLink}}`) with subscriber data
   - Uses inline CSS and references external stylesheet for styling  
4. **Email Sending:** SES sends personalized emails to each subscriber  
5. **Logging:** Lambda logs success/failure to CloudWatch Logs

---

## Example CSV Structure


---

## Security Considerations

### IAM Permissions

Lambda role (`infrastructure/role-policy.json`) includes:
- `s3:GetObject` for `email-marketing01/*`
- `ses:SendEmail`, `ses:SendRawEmail` for SES delivery
- `logs:*` for CloudWatch logging

### SES Verification
- The source email must be verified in SES to send emails

### Data Privacy
- Use sanitized data in `sample_data/contact.csv`
- Avoid committing real emails, credentials, or sensitive data to version control

### S3 Security
- Ensure the bucket is not publicly writable
- Access should be managed through IAM roles only

---

## Future Enhancements

- **DynamoDB**: Replace CSV with a DynamoDB table for dynamic subscriber management (e.g., `sample_data/subscribers.json`)
- **Analytics**: Add CloudWatch Metrics or SNS notifications to monitor success/failure rates
- **Custom Templates**: Support multiple templates in `templates/`
- **Unsubscribe Functionality**: Add `{{UnsubscribeLink}}` logic and backend handling

---

## Troubleshooting

| Issue                    | Solution                                                                 |
|--------------------------|--------------------------------------------------------------------------|
| Lambda Fails to Access S3 | Verify `s3:GetObject` permission in `role-policy.json` and bucket name  |
| SES Email Not Sent       | Confirm `SOURCE_EMAIL` is verified in SES and check your SES quota       |
| CloudWatch Trigger Fails | Ensure rule is enabled and has `lambda:InvokeFunction` permission        |
| Template Rendering Issues| Validate `templates/template1.html` syntax and placeholder usage         |

**Tip:** Enable verbose logging in `lambda/lambda_function.py` and monitor logs in `/aws/lambda/TechTideEmailSender` on CloudWatch.

---

## Additional Resources

- [AWS Lambda Documentation](https://docs.aws.amazon.com/lambda/latest/dg/welcome.html)
- [Amazon SES Documentation](https://docs.aws.amazon.com/ses/latest/dg/)
- [Amazon S3 Documentation](https://docs.aws.amazon.com/s3/index.html)
- [CloudWatch Events Documentation](https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/)

---

## Setup Guide

See `setup.md` for full deployment instructions.

## Contribution Guide

See `contributing.md` if you’d like to contribute to the project.

