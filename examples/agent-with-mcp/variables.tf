variable "mcp_lambda_arn" {
  description = "ARN of the Lambda function that implements MCP tools. The function should accept Bedrock action group invocations and translate them to MCP tool calls."
  type        = string
}

variable "region" {
  description = "AWS region for deployment."
  type        = string
  default     = "us-east-1"
}
