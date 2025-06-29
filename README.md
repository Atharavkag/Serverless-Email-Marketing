# TechTide – Serverless Email Marketing

**TechTide** is a serverless email marketing system that automates the delivery of weekly tech newsletters to subscribers. Built using AWS cloud-native services, the solution ensures high scalability, minimal maintenance, and a clean serverless architecture.

---

## 🌐 Overview

TechTide helps tech creators and teams distribute beautifully styled, personalized newsletters without managing servers or dealing with complex deployment pipelines. The system is fully automated — from scheduling to delivery.

---

## 🧱 Architecture Overview

The TechTide application leverages AWS Lambda, Amazon S3, Amazon SES, and Amazon EventBridge to deliver newsletters in a secure and scalable way.

### ✅ Architecture Flow

![TechTide Architecture]([https://raw.githubusercontent.com/Atharavkag/Serverless-Email-Marketing/main/assets/architecture-diagram.png](https://github.com/Atharavkag/Serverless-Email-Marketing/blob/main/assets/flow.png))

---

## 🧠 Key Components

| Component        | AWS Service       | Purpose                                                                 |
|------------------|-------------------|-------------------------------------------------------------------------|
| Email Sender     | AWS Lambda        | Executes business logic to fetch subscriber data and send emails       |
| Email Delivery   | Amazon SES        | Sends HTML emails to each subscriber                                   |
| Asset Storage    | Amazon S3         | Hosts templates, CSS files, images, and subscriber data                 |
| Scheduler        | EventBridge       | Triggers the Lambda function on a recurring weekly schedule             |

---

## 📊 Monitoring and Observability

TechTide uses AWS CloudWatch to monitor Lambda performance, invocation metrics, errors, and throttles. The system logs each email batch run and tracks delivery success via SES metrics.

### 📈 Sample Lambda Metrics

#### Invocation and Duration Trends

![Lambda Metrics 1](https://raw.githubusercontent.com/Atharavkag/Serverless-Email-Marketing/main/assets/lambda-metrics-1.png)

#### Success Rate and Errors

![Lambda Metrics 2](https://raw.githubusercontent.com/Atharavkag/Serverless-Email-Marketing/main/assets/lambda-metrics-2.png)

---

## 🔐 Security and IAM

TechTide enforces security by:

- Using IAM roles with scoped permissions for S3, SES, and Lambda
- Ensuring SES emails are verified before use
- Limiting public access to S3 buckets and templates
- Avoiding exposure of credentials in the repository

---

## 🚀 Deployment Highlights

The system is designed for rapid deployment using scripts and CloudFormation templates. Assets are version-controlled, templates are modular, and configuration is handled via environment variables. Setup is smooth for developers familiar with AWS basics.

---

## 💡 Future Enhancements

TechTide is extensible. Planned improvements include:

- Replacing CSV with a DynamoDB-based subscriber list
- Adding unsubscribe functionality
- Supporting dynamic A/B tested templates
- Enabling analytics and reporting via SNS or CloudWatch dashboards

---

## 🤝 Contributing

We welcome contributions from the open-source community. Please read the contribution guide in `contributing.md` before submitting a pull request.

---

## 📜 License

This project is licensed under the MIT License. See the `LICENSE` file for details.

---

## 📬 Contact

For feature requests, bug reports, or collaboration proposals, feel free to open an issue or reach out via the GitHub Discussions tab.

