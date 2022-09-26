# Local-only Data Source for Assume Role Policy
# Generates an IAM policy document in JSON format for use with resources that expect policy
data "aws_iam_policy_document" "lambda_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

# Local-only Data Source for create logs Cloudwatch Policy
data "aws_iam_policy_document" "safebot_create_logs_cloudwatch" {
  statement {
    sid       = "AllowCreatingLogGroups"
    effect    = "Allow"
    resources = ["arn:aws:logs:*:*:*"]
    actions   = ["logs:CreateLogGroup"]
  }

  statement {
    sid       = "AllowWritingLogs"
    effect    = "Allow"
    resources = ["arn:aws:logs:*:*:log-group:/aws/lambda/*:*"]

    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
  }
}

# Provides an IAM role
resource "aws_iam_role" "safebot_lambda_role" {
  name               = "safebot-lambda-role"
  description        = "Safebot lambda role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json

  tags = local.common_tags
}

# Provides an IAM policy
resource "aws_iam_policy" "create_logs_cloudwatch_policy" {
  name        = "create-cloudwatch-logs-policy"
  description = "Safebot create cloudwatch logs policy"
  policy      = data.aws_iam_policy_document.safebot_create_logs_cloudwatch.json
}

# Attaches a Managed IAM Policy to an IAM role
resource "aws_iam_role_policy_attachment" "safebot_cloudwatch_attachment" {
  policy_arn = aws_iam_policy.create_logs_cloudwatch_policy.arn
  role       = aws_iam_role.safebot_lambda_role.name
}
