output "lambdas" {
  value = [{
    arn           = aws_lambda_function.safebot.arn
    name          = aws_lambda_function.safebot.function_name
    version       = aws_lambda_function.safebot.version
    description   = aws_lambda_function.safebot.description
    last_modified = aws_lambda_function.safebot.last_modified
    api_gateway_url = aws_apigatewayv2_stage.lambda.invoke_url
  }]
}
