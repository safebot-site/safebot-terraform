resource "aws_lambda_function" "safebot" {
  function_name = "verify"
  handler       = "main.lambda_handler"
  role          = aws_iam_role.safebot_lambda_role.arn
  runtime       = "python3.10"

  filename         = "api.zip"
  source_code_hash = filebase64sha256("api.zip")

  timeout     = 20
  memory_size = 128

  tags = local.common_tags
}
