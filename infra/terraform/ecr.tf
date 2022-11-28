resource "aws_ecr_repository" "bot_dev" {
  name                 = "dmitriyshub-bot-dev"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "bot_prod" {
  name                 = "dmitriyshub-bot-prod"
  image_tag_mutability = "MUTABLE"


  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "worker_dev" {
  name                 = "dmitriyshub-worker-dev"
  image_tag_mutability = "MUTABLE"


  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "worker_prod" {
  name                 = "dmitriyshub-worker-prod"
  image_tag_mutability = "MUTABLE"


  image_scanning_configuration {
    scan_on_push = true
  }
}