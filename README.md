# 🎬 Amazon Prime Clone – Production DevOps Project

## 📌 Overview

This project demonstrates a **real-world, production-grade DevOps implementation** for deploying an **Amazon Prime Video–style application** using modern DevOps and cloud-native practices.

The solution covers **infrastructure provisioning, configuration management, CI/CD, security scanning, monitoring, and automation** using industry-standard tools.

---

## 🏗️ Architecture Highlights

* Infrastructure as Code using **Terraform**
* Configuration management with **Ansible**
* CI/CD using **Jenkins**
* Containerization with **Docker**
* Orchestration using **Kubernetes (EKS)**
* Code quality analysis with **SonarQube**
* Monitoring with **Prometheus & Grafana**
* Security scanning using **Trivy**
* GitOps-ready design

---

# 📁 Project Structure (Production Standard)

```text
devops-prime-video/
│
├── terraform/
│   ├── backend/
│   ├── infra/
│   │   ├── modules/
│   │   ├── backend.tf
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│
├── ansible/
│   ├── roles/
│   │   ├── docker/
│   │   ├── grafana/
│   │   ├── jenkins/
│   │   ├── nodejs/
│   │   ├── postgresql/
│   │   ├── prometheus/
│   │   ├── sonarQube/
│   │   └── trivy/
│   │
│   ├── ansible.cfg
│   ├── inventory
│   └── playbook.yml
│
├── README.md
└── .gitignore
```

---

## 🔐 Security Best Practices

* IAM **least-privilege access**
* No hardcoded credentials
* Secrets excluded from Git
* Private subnets for EKS worker nodes
* Public subnet only for Bastion / Jenkins
* Non-root containers and services

---

## ✅ Outcome

* Fully automated infrastructure provisioning
* Production-ready EKS cluster
* Secure CI/CD pipeline
* Integrated code quality & security scanning
* Scalable and fault-tolerant architecture

---

## 🛠️ Tech Stack

* **AWS** (EC2, EKS, ECR, IAM, VPC)
* **Terraform** – Infrastructure as Code
* **Ansible** – Configuration management
* **Jenkins** – CI/CD
* **Docker**
* **Kubernetes**
* **SonarQube**
* **Prometheus & Grafana**
* **Trivy**
* **AWS CLI**

---

# ✅ Prerequisites

## 1️⃣ Create IAM User (Programmatic Access)

### Step 1: Create IAM User

* AWS Console → IAM → Users → Create user
* Username:

```text
prod-devops-user
```

### Step 2: Enable Access Type

✅ Programmatic access (Access Key + Secret Key)

---

## 2️⃣ Attach Required IAM Policies

### ❌ Avoid

* `AdministratorAccess`

### ✅ Recommended Policies

* `AmazonEC2FullAccess`
* `AmazonEKSClusterPolicy`
* `AmazonEKSWorkerNodePolicy`
* `AmazonEC2ContainerRegistryFullAccess`
* `IAMReadOnlyAccess`

---

## 3️⃣ Generate AWS Credentials

Save securely:

```text
ACCESS_KEY_ID=xxxxxxxxxxxx
SECRET_ACCESS_KEY=xxxxxxxxxxxx
```

⚠️ **Never commit credentials to GitHub**

---

# 🔧 Local Machine Setup

## 4️⃣ Install AWS CLI

```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o awscliv2.zip
unzip awscliv2.zip
sudo ./aws/install
```

Verify:

```bash
aws --version
```

---

## 5️⃣ Configure AWS CLI

```bash
aws configure
```

```text
AWS Access Key ID     : <ACCESS_KEY>
AWS Secret Access Key : <SECRET_KEY>
Default region name   : us-east-1
Default output format : json
```

Validate:

```bash
aws sts get-caller-identity
```

---

## 6️⃣ Install Terraform

```bash
wget https://releases.hashicorp.com/terraform/1.7.5/terraform_1.7.5_linux_amd64.zip
unzip terraform_1.7.5_linux_amd64.zip
sudo mv terraform /usr/local/bin/
```

Verify:

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

Verify:

```bash
ansible --version
```

---

# 🚀 Terraform Workflow (Correct Order)

```bash
cd terraform/
terraform init
terraform validate
terraform plan
terraform apply
```

Type:

```text
yes
```

This provisions:

* VPC & networking
* EC2 instances
* EKS cluster
* ECR repositories

---

# 📘 Ansible Automation – Next Step After Terraform

Once infrastructure is ready, **Ansible configures all DevOps tools**.

---

## 📂 Ansible Repository Structure

```text
ansible/
├── roles/
│   ├── docker/
│   ├── grafana/
│   ├── jenkins/
│   ├── nodejs/
│   ├── postgresql/
│   ├── prometheus/
│   ├── sonarQube/
│   └── trivy/
│
├── ansible.cfg
├── inventory
└── playbook.yml
```

---

## 🧩 Roles Overview

| Role       | Purpose                        |
| ---------- | ------------------------------ |
| docker     | Install & configure Docker     |
| jenkins    | CI/CD server                   |
| nodejs     | Application runtime            |
| postgresql | Database backend               |
| sonarQube  | Code quality & analysis        |
| prometheus | Metrics collection             |
| grafana    | Monitoring dashboards          |
| trivy      | Security & vulnerability scans |

---

## 🗂 Inventory Configuration

```ini
[ec2]
<EC2_PUBLIC_IP> ansible_user=ec2-user ansible_ssh_private_key_file=key.pem
```

---

## ▶️ Run Ansible Automation

### Run all roles

```bash
ansible-playbook -i inventory playbook.yml
```

### Run a specific role

```bash
ansible-playbook -i inventory playbook.yml --tags sonarqube
```

---

## 🧠 Key Ansible Features

* PostgreSQL DB & schema automation
* Fully automated SonarQube deployment
* Kernel & OS tuning
* Secure non-root services
* systemd service management
* Safe re-runs (idempotent)

---

## 🔐 Default Access

### SonarQube

```text
http://<EC2_PUBLIC_IP>:9000
admin / admin
```

### Jenkins

```text
http://<EC2_PUBLIC_IP>:8080
```

⚠️ Change passwords after first login.

---

## 🎯 Use Cases

* End-to-end CI/CD pipeline
* Code quality enforcement
* Monitoring & observability
* Security scanning
* Interview-ready real-world DevOps project

---

## 👨‍💻 Author

**Manish Kumar Mittal**
DevOps Engineer | AWS | Azure | Terraform | Ansible | CI/CD | Kubernetes

---



inside the eks module 
change 
principal_arn = "arn:aws:iam::xxxxxxxxxxxxxxxxxxxxx"

and same rbac