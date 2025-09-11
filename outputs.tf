output "launch_template_latest_version" {
  description = "Latest version of the launch template"
  value       = aws_launch_template.this.latest_version
}

# Load Balancer outputs
output "load_balancer_dns_name" {
  description = "DNS name of the load balancer"
  value       = aws_lb.this.dns_name
}
