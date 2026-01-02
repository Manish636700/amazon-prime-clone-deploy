#!/bin/bash

sudo dnf update -y
sudo dnf install -y git unzip curl


sudo dnf install -y firewalld
systemctl enable firewalld
systemctl start firewalld




firewall-cmd --add-port=8080/tcp --permanent
firewall-cmd --add-port=3000/tcp --permanent
firewall-cmd --add-port=9090/tcp --permanent
firewall-cmd --add-port=9000/tcp --permanent
firewall-cmd --add-port=443/tcp --permanent
firewall-cmd --add-port=22/tcp --permanent
firewall-cmd --reload

curl -s https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip
unzip awscliv2.zip
./aws/install
rm -rf aws awscliv2.zip

sudo curl -Lo /usr/local/bin/cosign \
https://github.com/sigstore/cosign/releases/latest/download/cosign-linux-amd64

sudo chmod +x /usr/local/bin/cosign
cosign version


curl -LO https://dl.k8s.io/release/$(curl -Ls https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x kubectl
mv kubectl /usr/local/bin/

sudo mkdir -p /home/ec2-user/.kube
sudo chown ec2-user:ec2-user /home/ec2-user/.kube

sudo -u ec2-user aws eks update-kubeconfig \
  --region us-east-1 \
  --name prime-eks-prod \
  --kubeconfig /home/ec2-user/.kube/config
