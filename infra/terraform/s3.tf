resource "aws_s3_bucket" "video_bucket" {
  bucket = "dmitriyshub-video-bucket"

  tags = {
    Name        = "My bucket"
  }
}

resource "aws_s3_bucket_acl" "video_bucket_acl" {
  bucket = aws_s3_bucket.video_bucket.id
  acl    = "private"
}