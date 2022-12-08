resource "aws_s3_bucket" "video_bucket" {
  bucket = var.video_bucket

  tags = {
    Name        = "Bot-Video-Bucket"
  }
}

resource "aws_s3_bucket_acl" "video_bucket_acl" {
  bucket = aws_s3_bucket.video_bucket.id
  acl    = var.bucket_acl
}