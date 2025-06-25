data "aws_iam_policy_document" "fluent_bit" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
      "logs:PutLogEvents"
    ]

    resources = ["*"]
  }
}

resource "aws_iam_policy" "fluent_bit_logs" {
  name   = "FluentBitLogsAccess"
  policy = data.aws_iam_policy_document.fluent_bit.json
}