#!/bin/bash

# Pre
sudo yum update -y
sudo amazon-linux-extras install epel -y
sudo yum install git -y

# Docker
sudo amazon-linux-extras install docker -y
sudo service docker start
sudo systemctl enable docker

# Jenkins
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum upgrade -y
sudo amazon-linux-extras install java-openjdk11 -y
sudo yum install jenkins -y
sudo systemctl enable jenkins
sudo systemctl start jenkins

# Ansible
sudo yum update -y
sudo amazon-linux-extras install ansible2 -y

# users to group
sudo usermod -a -G docker ec2-user
sudo usermod -a -G docker jenkins

# Install the ECR Credentials helper
sudo amazon-linux-extras enable docker
sudo yum install amazon-ecr-credential-helper -y
sudo -u jenkins mkdir -p /var/lib/jenkins/.docker
echo '{"credsStore": "ecr-login"}' | sudo -u jenkins tee /var/lib/jenkins/.docker/config.json