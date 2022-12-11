#!/bin/bash

# Pre
sudo yum update –y
sudo amazon-linux-extras install epel -y

# Docker
sudo amazon-linux-extras install docker -y
sudo service docker start
sudo systemctl enable docker

# Git
sudo yum install git -y

# users to group
sudo usermod -a -G docker ec2-user


# k8s

git clone https://github.com/dmitriyshub/Jenkins-ex.git
cp Jenkins-ex/infra/k8s_helpers/* .
bash Jenkins-ex/infra.k8s_helpers/init-k0s-cluster-amazon-linux.sh > k8s_stdout.txt 2 > k8s_stderr.txt
kubectl create namespace dev
kubectl create namespace prod

