#!/bin/bash

yum install -y firewalld
systemctl start firewalld
systemctl enable firewalld

firewall-cmd --add-port=8080/tcp --permanent
firewall-cmd --add-port=3000/tcp --permanent
firewall-cmd --add-port=9090/tcp --permanent
firewall-cmd --add-port=9000/tcp --permanent
firewall-cmd --reload