resource "aws_lambda_function" "safebot" {
  function_name = "verify"
  handler       = "main.lambda_handler"
  role          = aws_iam_role.safebot_lambda_role.arn
  runtime       = "python3.9"

  filename         = "safebot.zip"
  source_code_hash = filebase64sha256("safebot.zip")

  timeout     = 20
  memory_size = 128

  tags = local.common_tags

  environment {
    variables = {
      ENVIRONMENT = "dev"
    }
  }
}
