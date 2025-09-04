# Auto Scaling Group outputs
output "autoscaling_group_name" {
  description = "Name of the created autoscaling group"
  value       = aws_autoscaling_group.this.name
}

output "autoscaling_group_arn" {
  description = "ARN of the created autoscaling group"
  value       = aws_autoscaling_group.this.arn
}

# Launch Template outputs
output "launch_template_id" {
  description = "ID of the launch template"
  value       = aws_launch_template.this.id
}

output "launch_template_latest_version" {
  description = "Latest version of the launch template"
  value       = aws_launch_template.this.latest_version
}

# Security Group outputs
output "security_group_id" {
  description = "ID of the security group created for the instances"
  value       = aws_security_group.this.id
}

# HCP Packer outputs
output "ami_id" {
  description = "AMI ID retrieved from HCP Packer"
  value       = data.hcp_packer_artifact.this.external_identifier
}

output "hcp_packer_build_id" {
  description = "HCP Packer build ID"
  value       = data.hcp_packer_artifact.this.build_id
}

# Scaling Policy outputs
output "scale_up_policy_arn" {
  description = "ARN of the scale up policy"
  value       = aws_autoscaling_policy.scale_up.arn
}

output "scale_down_policy_arn" {
  description = "ARN of the scale down policy"
  value       = aws_autoscaling_policy.scale_down.arn
}

# CloudWatch Alarms outputs
output "cpu_high_alarm_arn" {
  description = "ARN of the CPU high alarm"
  value       = aws_cloudwatch_metric_alarm.cpu_high.arn
}

output "cpu_low_alarm_arn" {
  description = "ARN of the CPU low alarm"
  value       = aws_cloudwatch_metric_alarm.cpu_low.arn
}
