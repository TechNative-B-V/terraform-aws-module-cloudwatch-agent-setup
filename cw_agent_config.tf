resource "aws_ssm_parameter" "cw_config_file" {
  name        = "/cloudwatch-config"
  description = "CloudWatch Agent standard configuration file."
  type        = "String"
  value       = file("${path.module}/cw_agent_config.json")
}
