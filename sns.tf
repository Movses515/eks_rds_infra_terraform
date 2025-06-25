resource "aws_sns_topic" "alerts" {
  name = "eks_alerts"
}

resource "aws_sns_topic_subscription" "email" {
  protocol  = "email"
  topic_arn = aws_sns_topic.alerts.arn
  endpoint  = "mmartirosyan69@gmail.com"
}