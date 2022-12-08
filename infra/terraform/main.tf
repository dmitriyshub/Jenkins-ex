# Configure the AWS Provider
provider "aws" {
  region = "us-west-2"
   default_tags {
   tags = {
     User = "dmitriyshub"
     Environment = "test"
     Owner       = "tf"
     Project     = "bot"
   }
 }
}

terraform {
  backend "s3" {
    bucket = "jenkins-ex-terraform-s3-dmitriyshub"
    key    = "jenkins/ex/state"
    region = "us-west-2"
  }
}






