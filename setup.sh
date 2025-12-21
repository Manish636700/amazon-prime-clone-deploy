#!/bin/bash
# ============================================================
# Author  : Manish Kumar Mittal
# Purpose : Provision AWS Infrastructure using Terraform
# Env     : Production
# ============================================================

set -euo pipefail

echo "============================================"
echo " 🚀 Starting Production Infrastructure Setup"
echo "============================================"

# -------------------------------
# Variables
# -------------------------------
PROJECT_NAME="prod-devops"
TIMESTAMP=$(date +%s)
KEY_NAME="${PROJECT_NAME}-${TIMESTAMP}"
SSH_DIR="$HOME/.ssh"
KEY_PATH="${SSH_DIR}/${KEY_NAME}"

TERRAFORM_DIR="$(pwd)/terraform"
BACKEND_DIR="${TERRAFORM_DIR}/backend"
INFRA_DIR="${TERRAFORM_DIR}/infra"

# -------------------------------
# Pre-checks
# -------------------------------
command -v terraform >/dev/null 2>&1 || { echo "❌ Terraform not installed"; exit 1; }
command -v ssh-keygen >/dev/null 2>&1 || { echo "❌ ssh-keygen not installed"; exit 1; }
command -v jq >/dev/null 2>&1 || { echo "❌ jq not installed. Install using: sudo apt install jq -y"; exit 1; }

mkdir -p "${SSH_DIR}"

# -------------------------------
# Generate SSH Key
# -------------------------------
echo "🔑 Generating SSH Key: ${KEY_NAME}"

ssh-keygen -t rsa -b 4096 -C "${KEY_NAME}" -f "${KEY_PATH}" -N ""

chmod 600 "${KEY_PATH}"
chmod 644 "${KEY_PATH}.pub"

echo "✅ SSH Key Generated Successfully"

# -------------------------------
# Export Terraform Variables
# -------------------------------
export TF_VAR_key_name="${KEY_NAME}"
export TF_VAR_public_key="$(cat ${KEY_PATH}.pub)"

echo "📦 Exported Terraform Variables"

# -------------------------------
# Terraform Backend
# -------------------------------
echo "============================================"
echo " 🌐 Provisioning Terraform Backend"
echo "============================================"

cd "${BACKEND_DIR}"

terraform init -reconfigure
terraform validate
terraform plan
terraform apply -auto-approve

echo "✅ Backend Provisioned Successfully"

# -------------------------------
# Terraform Infrastructure
# -------------------------------
echo "============================================"
echo " 🏗️ Provisioning Infrastructure"
echo "============================================"

cd "${INFRA_DIR}"

terraform init -reconfigure
terraform validate
terraform plan
terraform apply -auto-approve

echo "✅ Infrastructure Provisioned Successfully"

# -------------------------------
# Display Outputs
# -------------------------------
echo "============================================"
echo " 📤 Terraform Outputs"
echo "============================================"

terraform output

# -------------------------------
# SSH Information (Option 2)
# -------------------------------
echo "============================================"
echo " 🔐 SSH Access Information"
echo "============================================"

BASTION_IP=$(terraform output -json bastion_public_ip | jq -r '.public_ip // empty')

if [[ -n "$BASTION_IP" ]]; then
  echo "SSH Command:"
  echo "ssh -i ${KEY_PATH} ec2-user@${BASTION_IP}"
else
  echo "⚠️ Bastion IP not found in Terraform outputs"
fi

echo "============================================"
echo " ✅ Production Infrastructure Ready"
echo "============================================"
