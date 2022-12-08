resource "aws_ecr_repository" "bot_dev" {
  name                 = var.bot_dev_ecr
  image_tag_mutability = var.ecr_mutability

  image_scanning_configuration {
    scan_on_push = var.ecr_scan
  }
}

resource "aws_ecr_repository" "bot_prod" {
  name                 = var.bot_prod_ecr
  image_tag_mutability = var.ecr_mutability


  image_scanning_configuration {
    scan_on_push = var.ecr_scan
  }
}

resource "aws_ecr_repository" "worker_dev" {
  name                 = var.worker_dev_ecr
  image_tag_mutability = var.ecr_mutability


  image_scanning_configuration {
    scan_on_push = var.ecr_scan
  }
}

resource "aws_ecr_repository" "worker_prod" {
  name                 = var.worker_prod_ecr
  image_tag_mutability = var.ecr_mutability


  image_scanning_configuration {
    scan_on_push = var.ecr_scan
  }
}

resource "aws_ecr_repository" "jenkins_agent" {
  name                 = var.jenkins_agent_ecr
  image_tag_mutability = var.ecr_mutability


  image_scanning_configuration {
    scan_on_push = var.ecr_scan
  }
}