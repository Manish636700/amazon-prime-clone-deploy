#!/bin/bash
# ============================================================
# Author  : Manish Kumar Mittal
# Purpose : Provision AWS Infrastructure using Terraform
# Env     : Production
# ============================================================

set -euo pipefail

ROOT_DIR="$(pwd)"
TERRAFORM_DIR="${ROOT_DIR}/terraform"
BACKEND_DIR="${TERRAFORM_DIR}/backend"
INFRA_DIR="${TERRAFORM_DIR}/infra"
cd "${INFRA_DIR}"
terraform destroy -auto-approve

cd "${BACKEND_DIR}"
terraform destroy -auto-approve