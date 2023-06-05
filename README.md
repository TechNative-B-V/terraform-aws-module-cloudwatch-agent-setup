# Terraform AWS cloudwatch agent setup ![](https://img.shields.io/github/workflow/status/TechNative-B-V/terraform-aws-module-name/tflint.yaml?style=plastic)

<!-- SHIELDS -->

This module implements the needed roles and SSM parameter configuration for setting up CloudWatch agent via the SSM service. The setup only works with instances running in AWS.

[![](we-are-technative.png)](https://www.technative.nl)

## Prerequisite
- SSM agent must be pre-installed on the instance. (How to install SSM agent in an EC2 instance)[https://docs.aws.amazon.com/systems-manager/latest/userguide/agent-install-al.html]
## How does it work
1. Run the module to create the roles that are needed for CloudWatch to forward metrics.
2. Attach either the ```CloudWatchAgentServerRole``` or ```CloudWatchAgentAdminRole``` to the EC2 instance that needs to forward the metrics.
3. Use SSM run command and choose in the command document list the ```AWS-ConfigureAWSPackage``` to install CWagent if not already installed.
   a. In the name box fill in ``` AmazonCloudWatchAgent```
4. Use SSM run command and choose in the command document list the ```AmazonCloudWatchAgent``` to configure your CloudWatch Agent.
    a. In the Action list, choose configure.
    b. In the Optional Configuration Source list, choose ssm.
    c. In the Optional Configuration Location box, enter the name of the agent configuration file that you created and saved to Systems Manager Parameter Store.
    d. In the Optional Restart list, choose yes to start the agent
## Usage

To use this module ...

```hcl
module "cw_agent_setup" {
    source = "../modules/terraform-aws-module-cloudwatch-agent"
}
```

## AWS Documentation
- (Install CW agent on EC2 instance fleet)[https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/install-CloudWatch-Agent-on-EC2-Instance-fleet.html]
- (CW agent configuration file setup)[https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/create-cloudwatch-agent-configuration-file-wizard.html]

<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cw_admin_role"></a> [cw\_admin\_role](#module\_cw\_admin\_role) | git@github.com:TechNative-B-V/terraform-aws-module-iam-role.git | 818f7b89e9b98423fb5517f124c80aa847936e98 |
| <a name="module_instance_role"></a> [instance\_role](#module\_instance\_role) | git@github.com:TechNative-B-V/terraform-aws-module-iam-role.git | 818f7b89e9b98423fb5517f124c80aa847936e98 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_instance_profile.cw_agent](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_instance_profile.cw_agent_admin](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_ssm_parameter.cw_config_file](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cw_config_parameter_name"></a> [cw\_config\_parameter\_name](#output\_cw\_config\_parameter\_name) | n/a |
<!-- END_TF_DOCS -->
