data "aws_iam_policy_document" "continuous_lambda_role_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "stream_iam_policy" {
  statement {
    effect = "Allow"

    actions = [
      "kinesis:PutRecord*",
      "kinesis:DescribeStream",
      "kinesis:ListStreams",
      "kinesis:GetShardIterator",
      "kinesis:GetRecords",
    ]

    resources = [
      "${aws_kinesis_stream.sample_stream.arn}",
    ]
  }
}

resource "aws_iam_role_policy" "consumer_role_policy" {
  name   = "continuous_lambda_role_policy"
  role   = "${aws_iam_role.continuous_lambda_iam_role.name}"
  policy = "${data.aws_iam_policy_document.stream_iam_policy.json}"
}

resource "aws_iam_role" "continuous_lambda_iam_role" {
  name               = "continuous_lambda_role"
  assume_role_policy = "${data.aws_iam_policy_document.continuous_lambda_role_policy.json}"
}
