variable "key_name" {
  description = "environment tag"
  default     = "my_key"
}

variable "jenkins_ami" {
  description = "jenkins_ami_id"
  default     = "ami-01c82e0df2f2136f6"
}

variable "k8s_ami" {
  description = "k8s_ami_id"
  default     = "ami-0b782e3168c62cf7b"
}