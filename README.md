# TechTide – Serverless Email Marketing

**TechTide** is a cloud-native, serverless email marketing solution designed to send personalized, HTML-based tech newsletters to subscribers on a weekly schedule. Built entirely using AWS services, TechTide ensures high availability, cost-efficiency, and automated email delivery — without provisioning or managing servers.

---

## Project Overview

TechTide enables tech bloggers, communities, and organizations to send engaging newsletters without relying on third-party marketing platforms. With simple CSV-based subscriber management and a flexible HTML email template system, it's ideal for developers who want full control over email content, automation, and branding.

---

## Technologies Used

TechTide is built using the following AWS services:

- **Amazon S3**: Stores email templates, assets, and subscriber data (CSV).
- **AWS Lambda**: Core logic for rendering templates and sending emails.
- **Amazon SES (Simple Email Service)**: Handles email delivery.
- **Amazon EventBridge**: Triggers Lambda weekly via cron expressions.
- **AWS CloudWatch**: Logs and monitors Lambda performance.
- **CloudFormation (optional)**: Automates infrastructure setup.

---

## Architecture Flow

The system follows a clean event-driven architecture that runs autonomously once deployed.

![TechTide Architecture](https://raw.githubusercontent.com/Atharavkag/Serverless-Email-Marketing/main/assets/flow.png)

**Flow Summary:**

1. Subscriber data is uploaded to Amazon S3 as a CSV file.
2. A weekly scheduled event triggers the Lambda function.
3. The Lambda function reads subscriber data and loads the HTML template from S3.
4. Emails are rendered with personalized content and sent via Amazon SES.
5. Logs and metrics are stored in CloudWatch for monitoring.

---

## 📊 Lambda Monitoring

Monitoring is enabled through AWS CloudWatch, giving visibility into Lambda invocations, durations, and failures.

#### Invocation Overview:

![Lambda Metrics 1](https://raw.githubusercontent.com/Atharavkag/Serverless-Email-Marketing/main/assets/lambda-metrics-1.png)

#### Execution & Success Trends:

![Lambda Metrics 2](https://raw.githubusercontent.com/Atharavkag/Serverless-Email-Marketing/main/assets/lambda-metrics-2.png)

---

## 🔐 Security Highlights

- All S3 assets are stored in private buckets with access controlled via IAM roles.
- SES is configured with a verified sender to avoid spoofing or spam.
- Lambda roles are scoped with least-privilege permissions.
- No sensitive data (like real email addresses or credentials) is committed to the repository.

---

## Use Cases

- Sending weekly or monthly newsletters to a subscriber list.
- Sharing tech news, product updates, blog summaries, or event announcements.
- Building your own private newsletter system without third-party tools.
- Integrating with a future web frontend, form submission system, or CMS.

---

## Highlights

- **Completely serverless**: No EC2 or container setup required.
- **Flexible templates**: Easily update HTML/CSS-based templates in S3.
- **Automated scheduling**: Fully hands-off once deployed.
- **Custom branding**: Personalize the design to match your identity.
- **Extendable design**: Easily integrate with DynamoDB, SNS, or a web interface.

---

## 🛣Future Roadmap

TechTide is built to scale. Planned improvements include:

- ⚙️ DynamoDB-based subscriber management
- 🧾 Unsubscribe functionality with secure token-based links
- 📬 Support for multiple templates and campaigns
- 📈 Analytics dashboard for tracking open and click rates
- 💻 Admin dashboard for uploading subscribers and previewing content

---

## Contributing

Have suggestions, fixes, or improvements? Contributions are welcome!

- Fork the repository
- Create a new branch
- Commit your changes
- Open a pull request with a clear description

For contribution standards, see [`contributing.md`](./contributing.md)

---


## 📚 Related AWS Resources

- [Amazon SES](https://docs.aws.amazon.com/ses/)
- [AWS Lambda](https://docs.aws.amazon.com/lambda/)
- [Amazon EventBridge](https://docs.aws.amazon.com/eventbridge/)
- [Amazon S3](https://docs.aws.amazon.com/s3/)
- [AWS CloudWatch](https://docs.aws.amazon.com/cloudwatch/)
