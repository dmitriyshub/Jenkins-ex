#Create an IAM Policy
resource "aws_iam_policy" "k8s_policy" {
  name        = "k8s-Access-Policy"
  description = "Provides permission to k8s"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "*",
        ]
        Effect   = "Allow"
        Resource = [
          "*"
        ]
      },
    ]
  })
}

#Create an IAM Role
resource "aws_iam_role" "k8s-role" {
  name = "k8s_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = "RoleForEC2"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_policy_attachment" "k8s-attach" {
  name       = "k8s-policy-attachment"
  roles      = [aws_iam_role.k8s-role.name]
  policy_arn = aws_iam_policy.k8s_policy.arn
}

resource "aws_iam_instance_profile" "k8s-profile" {
  name = "k8s_profile"
  role = aws_iam_role.k8s-role.name
}