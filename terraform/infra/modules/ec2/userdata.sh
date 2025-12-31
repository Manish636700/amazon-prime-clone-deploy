#!/bin/bash

yum update -y
yum install -y git unzip curl

yum install -y firewalld 

if systemctl list-unit-files | grep -q firewalld; then
  systemctl stop firewalld || true
  systemctl disable firewalld || true
fi


# firewall-cmd --add-port=8080/tcp --permanent
# firewall-cmd --add-port=3000/tcp --permanent
# firewall-cmd --add-port=9090/tcp --permanent
# firewall-cmd --add-port=9000/tcp --permanent
# firewall-cmd --reload

curl -s https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip
unzip awscliv2.zip
./aws/install
rm -rf aws awscliv2.zip

curl -LO https://dl.k8s.io/release/$(curl -Ls https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x kubectl
mv kubectl /usr/local/bin/

sudo mkdir -p /home/ec2-user/.kube
sudo chown ec2-user:ec2-user /home/ec2-user/.kube

sudo -u ec2-user aws eks update-kubeconfig \
  --region us-east-1 \
  --name prime-eks-prod \
  --kubeconfig /home/ec2-user/.kube/config
