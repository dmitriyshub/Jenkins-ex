
// Launching new EC2 instance
resource "aws_instance" "k8sInstance" {
    ami = var.ami_id
    instance_type = "t2.micro"
    key_name = "my_key"
    vpc_security_group_ids = ["${aws_security_group.allow_tcp.id}"]
    subnet_id = aws_subnet.public_subnet.id
    tags = {
        Name = "k8sInstance"
    }
}


// Launching new EC2 instance
resource "aws_instance" "jenkinsInstance" {
    ami = var.ami_id
    instance_type = "t2.micro"
    key_name = "my_key"
    vpc_security_group_ids = ["${aws_security_group.allow_tcp.id}"]
    subnet_id = aws_subnet.public_subnet.id
    tags = {
        Name = "jenkinsInstance"
    }
}