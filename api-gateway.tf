resource "aws_api_gateway_rest_api" "safebot" {
  body = jsonencode({
    openapi = "3.0.1"
    info = {
      title   = "safebot"
      version = "1.0"
    }
    paths = {
      "/verify/{proxy+}" = {
        get = {
          x-amazon-apigateway-integration = {
            httpMethod           = "GET"
            payloadFormatVersion = "1.0"
            type                 = "AWS_PROXY"
            uri                  = "arn:aws:lambda:sa-east-1:379156197353:function:verify"
          }
        }
      }
    }
  })

  name = "safebot_apigateway"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_deployment" "safebot" {
  rest_api_id = aws_api_gateway_rest_api.safebot.id

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.safebot.body))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "safebot" {
  deployment_id = aws_api_gateway_deployment.safebot.id
  rest_api_id   = aws_api_gateway_rest_api.safebot.id
  stage_name    = "dev"
}