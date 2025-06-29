# Contributing to TechTide

**TechTide** welcomes contributions to enhance its serverless email marketing application. This guide outlines how to contribute, from setting up your environment to submitting pull requests, ensuring a smooth and collaborative process.

---

## Why Contribute?

By contributing, you can:
- Improve the application’s functionality (e.g., add new email templates).
- Fix bugs or enhance performance.
- Update documentation for clarity and accuracy.
- Build a portfolio of open-source contributions.

---

## Getting Started

### Prerequisites

- **Git**: For version control (`git --version`).
- **Python 3.8+**: For local development and testing.
- **AWS CLI**: For deploying and testing AWS resources.
- **Code Editor**: VS Code, PyCharm, or similar.

### Setup Local Environment

Follow [setup.md](setup.md) to clone the repository and configure AWS:

```bash
git clone https://github.com/Atharavkag/TechTide.git
cd TechTide
pip install -r requirements.txt
aws configure
bash scripts/setup.sh
```

---

## Contribution Workflow

### 1. Fork the Repository

1. Go to `https://github.com/Atharavkag/TechTide`.
2. Click **Fork** to create a copy in your GitHub account.

### 2. Clone Your Fork

Clone your forked repository locally:

```bash
git clone https://github.com/your-username/TechTide.git
cd TechTide
```

### 3. Create a Feature Branch

Create a branch for your changes:

```bash
git checkout -b feature/your-feature-name
```

**Examples**:
- `feature/add-dynamodb-support`
- `bugfix/s3-access-error`
- `docs/update-readme`

### 4. Make Changes

- **Code**: Modify files in `lambda/` (e.g., `lambda_function.py`) for new features or fixes.
- **Tests**: Add or update tests in `lambda/tests/` (e.g., `test_lambda.py`).
- **Documentation**: Update `docs/` files for clarity or new features.
- **Templates**: Enhance `templates/template1.html` or `styles/styles.css` for better email design.

**Example**: To add a new CSS style:
1. Edit `styles/styles.css` to add a new class.
2. Update `templates/template1.html` to use the class.
3. Test locally with `scripts/test_email.sh`.

### 5. Test Your Changes

Run unit tests to ensure code quality:

```bash
pytest lambda/tests/test_lambda.py
```

Test email sending locally:

```bash
bash scripts/test_email.sh
```

> **Note**: Ensure the S3 bucket (`email-marketing01`) and SES email are configured before testing.

### 6. Commit Changes

Write a clear, concise commit message:

```bash
git add .
git commit -m "feat: add new email template style"
```

**Commit Message Guidelines**:
- Use **Conventional Commits** (e.g., `feat:`, `fix:`, `docs:`).
- Keep messages under 72 characters.
- Example: `fix: handle empty CSV in lambda_function.py`

### 7. Push to Your Fork

Push your branch to your forked repository:

```bash
git push origin feature/your-feature-name
```

### 8. Create a Pull Request

1. Go to your fork on GitHub (`https://github.com/your-username/TechTide`).
2. Click **New Pull Request**.
3. Select your branch (`feature/your-feature-name`) and the main repository’s `main` branch.
4. Write a detailed PR description:
   - What you changed.
   - Why it’s needed.
   - How you tested it.
5. Submit the PR.

---

## Contribution Guidelines

| **Category**       | **Guidelines**                                                                 |
|--------------------|-------------------------------------------------------------------------------|
| **Code Style**     | Follow [PEP 8](https://www.python.org/dev/peps/pep-0008/) for Python code.   |
| **Testing**        | Add tests in `lambda/tests/` for new features. Run `pytest` before committing. |
| **Documentation**  | Update `docs/` for any new features or changes to existing functionality.      |
| **Commits**        | Use meaningful commit messages. Avoid large, unrelated changes in one commit. |
| **Security**       | Do not include sensitive data (e.g., API keys, real emails) in the repository. |

**Example PR Description**:

```markdown
**Title**: Add support for custom email subjects

**Description**:
- Modified `lambda_function.py` to accept a subject parameter from `config/ses_config.json`.
- Updated `docs/setup.md` with new configuration instructions.
- Added test case in `lambda/tests/test_lambda.py`.

**Testing**:
- Ran `pytest lambda/tests/test_lambda.py` (all tests passed).
- Tested email sending with `scripts/test_email.sh`.

**Related Issues**: #12
```

---

## Code Review Process

- **Review**: Maintainers will review your PR within 3-5 days.
- **Feedback**: Address any requested changes by pushing new commits to your branch.
- **Approval**: Once approved, your PR will be merged into `main`.

---

## Example Contributions

| **Contribution**                | **Files to Modify**                              | **Steps**                                                                 |
|--------------------------------|------------------------------------------------|---------------------------------------------------------------------------|
| Fix Lambda error handling      | `lambda/lambda_function.py`, `lambda/tests/`    | Add try-catch blocks, update tests, test with `test_email.sh`.            |
| Improve email template design   | `templates/template1.html`, `styles/styles.css` | Add new styles, update HTML, test rendering with `test_email.sh`.         |
| Enhance documentation           | `docs/`                                        | Add sections, examples, or diagrams to `architecture.md` or `setup.md`.   |

---

## Troubleshooting

- **Git Conflicts**: Resolve conflicts using `git pull origin main --rebase`.
- **Test Failures**: Check CloudWatch logs or run `pytest -v` for detailed output.
- **AWS Errors**: Verify IAM permissions and SES email verification.

> **Tip**: Join our community (link TBD) for support or to discuss ideas!

---

## Contact

For questions, reach out via GitHub Issues or email (contact TBD).

Thank you for contributing to *TechTide*! 🚀