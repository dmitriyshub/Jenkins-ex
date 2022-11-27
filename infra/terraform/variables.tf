variable "key_name" {
  description = "environment tag"
  default     = "my_key"
}

variable "jenkins_id" {
  description = "jenkins_ami_id"
  default     = "ami-0996adae06dd4e01f"
}

variable "k8s_ami" {
  description = "k8s_ami_id"
  default     = "ami-03f37d57f7425c25c"
}