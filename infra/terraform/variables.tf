#################
# bot variables #
#################


variable "vpc_cidr" {
  description = "vpc cidr block"
  default = "10.1.0.0/16"
}
variable "public_subnet_cidr" {
  description = "public subnet cidr"
  default = "10.1.1.0/24"
}

variable "egress_cidr" {
  description = "egress cidr"
  default = "0.0.0.0/0"
}

variable "vpc_tenancy" {
  description = "vpc tenancy type"
  default = "default"
}

variable "backend_bucket" {
  default = "jenkins-ex-terraform-s3-dmitriyshub"
}

variable "region" {
  description = "aws region"
  default = "us-west-2"
}

variable "availability_zone" {
  description = "first availability zone"
  default = "us-west-2a"
}

variable "instance_type" {
  description = "ec2 instance type"
  default = "t2.small"
}

variable "key_name" {
  description = "environment tag"
  default     = "my_key"
}

############################
# instance AMIs from packer#
############################

variable "jenkins_ami" {
  description = "jenkins_ami_id"
  default     = "ami-01c82e0df2f2136f6"
}

variable "k8s_ami" {
  description = "k8s_ami_id"
  default     = "ami-0b782e3168c62cf7b"
}

##################
# ecr registries #
##################

variable "bot_dev_ecr" {
  description = "bot ecr registry dev name"
  default     = "dmitriyshub-bot-dev"
}

variable "bot_prod_ecr" {
  description = "bot ecr registry prod name"
  default     = "dmitriyshub-bot-prod"
}

variable "worker_dev_ecr" {
  description = "worker ecr registry dev name"
  default     = "dmitriyshub-worker-dev"
}

variable "worker_prod_ecr" {
  description = "worker ecr registry prod name"
  default     = "dmitriyshub-worker-prod"
}

variable "jenkins_agent_ecr" {
  description = "jenkins agent ecr name"
  default = "dmitriyshub-agent"
}

#####################
# ecr configuration #
#####################

variable "ecr_mutability" {
  description = "ecr mutable"
  default = "MUTABLE"
}

variable "ecr_scan" {
  description = "ecr scan mode"
  default = true
}

###################
# s3 video bucket #
###################

variable "video_bucket" {
  description = "bot video bucket name"
  default = "dmitriyshub-video-bucket"
}

variable "video_bucket_key" {
  description = "bot video bucket key"
  default = "jenkins/ex/state"
}

variable "bucket_acl" {
  description = "bucket access control list"
  default = "private"
}

#############
# sqs queue #
#############

variable "sqs_queue" {
  description = "bot sqs name"
  default = "dmitriyshub-bot-queue"
}