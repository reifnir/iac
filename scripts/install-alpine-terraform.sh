#!/bin/bash
# requires: curl, unzip, jq
set -e

echo "Installing terraform..."
echo "  Getting current TF version..."
TF_CURRENT_VERSION="$(curl -s https://checkpoint-api.hashicorp.com/v1/check/terraform | jq '.current_version' -r)"
echo "  TF_CURRENT_VERSION=$TF_CURRENT_VERSION"
echo "  Downloading terraform zip..."
curl -s "https://releases.hashicorp.com/terraform/${TF_CURRENT_VERSION}/terraform_${TF_CURRENT_VERSION}_linux_amd64.zip" -o /tmp/tf.zip
echo "  Unzipping terraform to /usr/local/bin"
unzip /tmp/tf.zip -d /usr/local/bin
echo "Granting execute permission on terraform..."
chmod +x /usr/local/bin/terraform
echo "Cleaning up..."
rm /tmp/tf.zip
