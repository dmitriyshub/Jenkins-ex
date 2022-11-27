#!/bin/bash

# Pre
sudo yum update –y
sudo amazon-linux-extras install epel -y
sudo apt-get install software-properties-common -y

# Docker
sudo amazon-linux-extras install docker
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