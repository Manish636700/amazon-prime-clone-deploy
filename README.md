# Amazon Prime Clone – Production DevOps Project

## Overview
This project demonstrates a real-world, production-grade DevOps implementation for deploying an Amazon Prime Video clone application using AWS, Terraform, Jenkins, Docker, Kubernetes (EKS), and GitOps practices.


# 📁 PROJECT STRUCTURE (Production Standard)

```
devops-prime-video/
│
├── terraform/
│   ├── backend/
│   ├── infra/
│       ├── modules/
│       └── backend.tf
│       └── main tf files
│
├── ansible/
│   └── role/
│       └── jenkins/
│       └── sonarqube.....etc/
│   └── invertroy
│   └── playbook
├── README.md
└── .gitignore
```

---


## Security Best Practices

* IAM least privilege access
* No hardcoded credentials
* Private subnets for EKS nodes
* Public subnet only for Bastion/Jenkins
* Non-root containers

## Outcome

* Fully automated infrastructure
* Production-ready EKS cluster
* CI/CD pipeline with security scanning
* Scalable and secure architecture

## Tech Stack
- AWS (EC2, EKS, ECR, IAM, VPC)
- Terraform (Infrastructure as Code)
- Jenkins (CI/CD)
- Docker
- Kubernetes
- Ansible
- AWS CLI

# ✅ PREREQUISITES 

## 1️⃣ Create IAM User (Programmatic Access)

### 🔹 Step 1: Create IAM User

* Go to **AWS Console → IAM → Users → Create user**
* Username:

```
prod-devops-user
```

### 🔹 Step 2: Enable Access Type

✅ **Programmatic access** (Access Key + Secret Key)

---

## 2️⃣ Attach Required Permissions (Correct & Secure)

### ❌ Avoid:

* Giving `AdministratorAccess` blindly

### ✅ Recommended Policies

Attach the following AWS managed policies:

* `AmazonEC2FullAccess`
* `AmazonEKSClusterPolicy`
* `AmazonEKSWorkerNodePolicy`
* `AmazonEC2ContainerRegistryFullAccess`
* `IAMReadOnlyAccess`

👉 This is **sufficient for EC2 + EKS + ECR + Terraform**

---

## 3️⃣ Generate Security Credentials

* Open IAM User → **Security Credentials**
* Create **Access Key**
* Save securely:

```
ACCESS_KEY_ID=xxxxxxxxxxxx
SECRET_ACCESS_KEY=xxxxxxxxxxxx
```

⚠️ **Never commit these to GitHub**

---

# 🔧 LOCAL MACHINE SETUP

## 4️⃣ Install AWS CLI

### Linux

```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o awscliv2.zip
unzip awscliv2.zip
sudo ./aws/install
```

### Verify

```bash
aws --version
```

---

## 5️⃣ Configure AWS CLI

Run:

```bash
aws configure
```

Fill details:

```
AWS Access Key ID     : <ACCESS_KEY>
AWS Secret Access Key : <SECRET_KEY>
Default region name   : us-east-1
Default output format : json
```

✅ Validate:

```bash
aws sts get-caller-identity
```

---

## 6️⃣ Install Terraform

### Linux

```bash
wget https://releases.hashicorp.com/terraform/1.7.5/terraform_1.7.5_linux_amd64.zip
unzip terraform_1.7.5_linux_amd64.zip
sudo mv terraform /usr/local/bin/
```

### Verify

```bash
terraform version
```

---

## 7️⃣ Install Ansible

### Amazon Linux / RHEL

```bash
sudo yum install ansible -y
```

### Ubuntu

```bash
sudo apt update && sudo apt install ansible -y
```

### Verify

```bash
ansible --version
```

---

# 🚀 TERRAFORM WORKFLOW (Correct Order)

Navigate to your Terraform directory:

```bash
cd terraform/
```

### 1️⃣ Initialize Terraform

```bash
terraform init
```

### 2️⃣ Validate Configuration

```bash
terraform validate
```

### 3️⃣ Review Execution Plan

```bash
terraform plan
```

### 4️⃣ Apply Infrastructure

```bash
terraform apply
```

Type:

```bash
yes
```

✅ This will create:

* VPC
* Subnets
* EC2 / EKS / ECR (as per your code)

---



