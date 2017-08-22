resource "aws_lambda_function" "continuous_lambda" {
  function_name    = "continuous_lambda"
  filename         = "../lambda.zip"
  role             = "${aws_iam_role.continuous_lambda_iam_role.arn}"
  handler          = "main.handler"
  source_code_hash = "${base64sha256(file("../lambda.zip"))}"
  timeout          = 10
  publish          = true
  runtime          = "python3.6"
}

resource "aws_lambda_alias" "test_alias" {
  name             = "production"
  function_name    = "${aws_lambda_function.continuous_lambda.arn}"
  function_version = "$LATEST"
}

resource "aws_lambda_event_source_mapping" "event_source_mapping" {
  batch_size        = 100
  event_source_arn  = "${aws_kinesis_stream.sample_stream.arn}"
  enabled           = true
  function_name     = "${aws_lambda_alias.test_alias.arn}"
  starting_position = "TRIM_HORIZON"
}