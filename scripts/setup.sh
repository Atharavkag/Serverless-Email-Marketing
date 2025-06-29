#!/bin/bash
set -e

aws s3 mb s3://email-marketing01
aws ses verify-email-identity --email-address atharavkagde7@gmail.com
echo "Setup complete. Verify email in SES console."
