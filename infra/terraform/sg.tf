// Creating aws security resource
resource "aws_security_group" "allow_tcp" {
  name        = "allow_tcp"
  description = "Allow TCP inbound traffic"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    description = "TCP from VPC"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
   ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
      Name = "main_sg"

  }
}