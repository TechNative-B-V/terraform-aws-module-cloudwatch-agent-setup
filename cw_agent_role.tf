# EC2 instance role to be attached to an instance in order to send metrics to the CloudWatch Service.

# Use this role just for pushing instance metrics to CloudWatch.
resource "aws_iam_instance_profile" "cw_agent" {
  name = "cw_agent_profile"
  role = module.instance_role.role_name
}

module "instance_role" {

  source = "git@github.com:TechNative-B-V/terraform-aws-module-iam-role.git?ref=818f7b89e9b98423fb5517f124c80aa847936e98"

  role_name            = "CloudWatchAgentServerRole"
  aws_managed_policies = ["CloudWatchAgentServerPolicy", "AmazonSSMManagedInstanceCore"]
  trust_relationship = {
    "EC2" : { "identifier" : "ec2.amazonaws.com", "identifier_type" : "Service", "enforce_mfa" : false, "enforce_userprincipal" : false, "external_id" : null, "prevent_account_confuseddeputy" : false }
  }
}

# Use this role which has a wider permissions for setting up CW agent.
resource "aws_iam_instance_profile" "cw_agent_admin" {
  name = "cw_admin_profile"
  role = module.cw_admin_role.role_name
}

module "cw_admin_role" {

  source = "git@github.com:TechNative-B-V/terraform-aws-module-iam-role.git?ref=818f7b89e9b98423fb5517f124c80aa847936e98"

  role_name            = "CloudWatchAgentAdminRole"
  aws_managed_policies = ["CloudWatchAgentAdminPolicy", "AmazonSSMManagedInstanceCore"]
  trust_relationship = {
    "EC2" : { "identifier" : "ec2.amazonaws.com", "identifier_type" : "Service", "enforce_mfa" : false, "enforce_userprincipal" : false, "external_id" : null, "prevent_account_confuseddeputy" : false }
  }
}
