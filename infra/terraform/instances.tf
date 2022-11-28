
// Launching k8s EC2 instance
resource "aws_instance" "k8sInstance" {
    ami = var.k8s_ami
    instance_type = "t2.small"
    key_name = "my_key"
    vpc_security_group_ids = ["${aws_security_group.allow_tcp_k8s.id}"]
    subnet_id = aws_subnet.public_subnet.id
    iam_instance_profile = aws_iam_instance_profile.k8s-profile.name
    tags = {
        Name = "k8sInstance"
    }
}


// Launching Jenkins EC2 instance
resource "aws_instance" "jenkinsInstance" {
    ami = var.jenkins_ami
    instance_type = "t2.small"
    key_name = "my_key"
    vpc_security_group_ids = ["${aws_security_group.allow_tcp_jenkins.id}"]
    subnet_id = aws_subnet.public_subnet.id
    iam_instance_profile = aws_iam_instance_profile.k8s-profile.name

    root_block_device {
      tags                  = {}
      volume_size           = 30

  }

    tags = {
        Name = "jenkinsInstance"
    }
}

output "jenkins_public_ip" {
    value = aws_instance.jenkinsInstance.public_ip
}

output "k8s_public_ip" {
    value = aws_instance.k8sInstance.public_ip
}