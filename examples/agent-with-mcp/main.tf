# Example: Bedrock Agent with MCP (Model Context Protocol) Tools
#
# This example demonstrates how to create a Bedrock agent that uses
# MCP-compatible action groups. MCP enables agents to interact with
# external services through a standardized protocol.
#
# Architecture:
#   Bedrock Agent -> Lambda (MCP Server) -> External Service
#
# The Lambda function acts as an MCP server, translating between
# Bedrock's action group format and MCP tool calls.
#
# Prerequisites:
#   - A Lambda function implementing MCP tools (see README.md)
#   - AWS Bedrock model access enabled in your region
#
# References:
#   - MCP Specification: https://modelcontextprotocol.io/
#   - Bedrock Agents: https://docs.aws.amazon.com/bedrock/latest/userguide/agents.html
#   - AWS MCP Servers: https://github.com/awslabs/mcp

module "bedrock_agent_mcp" {
  source = "../../"

  # Agent configuration
  agent_name        = "mcp-enabled-agent"
  agent_description = "Bedrock agent with MCP tool integration"
  foundation_model  = "anthropic.claude-sonnet-4-6-v1"
  instruction       = "You are a helpful assistant with access to external tools via MCP. Use the available action groups to help users with their requests."

  # Use name_prefix instead of random prefix
  name_prefix = "mcp"

  # Tags propagated to all resources (including awscc_*)
  tags = {
    Environment = "development"
    Project     = "mcp-integration"
    ManagedBy   = "terraform"
  }

  # Agent configuration
  create_agent       = true
  create_agent_alias = true
  agent_alias_name   = "live"

  # Action group pointing to MCP Lambda
  lambda_action_group_executor = var.mcp_lambda_arn

  action_group_name        = "mcp-tools"
  action_group_description = "MCP-compatible tools exposed as Bedrock action group"
  action_group_state       = "ENABLED"
}
