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
output "target_tracking_policy_arn" {
  description = "ARN of the target tracking scaling policy"
  value       = aws_autoscaling_policy.target_tracking_cpu.arn
}

# Load Balancer outputs
output "load_balancer_dns_name" {
  description = "DNS name of the load balancer"
  value       = aws_lb.this.dns_name
}

output "load_balancer_zone_id" {
  description = "Canonical hosted zone ID of the load balancer"
  value       = aws_lb.this.zone_id
}

output "load_balancer_arn" {
  description = "ARN of the load balancer"
  value       = aws_lb.this.arn
}

output "target_group_arn" {
  description = "ARN of the target group"
  value       = aws_lb_target_group.this.arn
}
