resource "aws_sqs_queue" "sqs_queue" {
  name                      = "dmitriyshub-bot-queue"
  delay_seconds             = 10
  max_message_size          = 262144
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
  visibility_timeout_seconds = 1800

  tags = {
    Name = "dmitriyshub-bot-queue"
  }
}