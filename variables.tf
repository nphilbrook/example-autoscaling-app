variable "name_prefix" {
  description = "Name prefix for all resources"
  type        = string
  default     = "example-app"

  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.name_prefix))
    error_message = "Name prefix must contain only lowercase letters, numbers, and hyphens."
  }
}

variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be one of: dev, staging, prod."
  }
}

# Instance Configuration
variable "instance_type" {
  description = "EC2 instance type for the autoscaling group"
  type        = string
  default     = "t3.micro"
}

variable "key_pair_name" {
  description = "Name of the AWS key pair for SSH access"
  type        = string
  default     = null
}

# Auto Scaling Configuration
variable "min_size" {
  description = "Minimum number of instances in the autoscaling group"
  type        = number
  default     = 1

  validation {
    condition     = var.min_size >= 0
    error_message = "Minimum size must be greater than or equal to 0."
  }
}

variable "max_size" {
  description = "Maximum number of instances in the autoscaling group"
  type        = number
  default     = 5

  validation {
    condition     = var.max_size >= var.min_size
    error_message = "Maximum size must be greater than or equal to minimum size."
  }
}

variable "desired_capacity" {
  description = "Desired number of instances in the autoscaling group"
  type        = number
  default     = 1

  validation {
    condition     = var.desired_capacity >= var.min_size && var.desired_capacity <= var.max_size
    error_message = "Desired capacity must be between minimum and maximum size."
  }
}

# Application Configuration
variable "app_port" {
  description = "Port number that the application listens on"
  type        = number
  default     = 80
}

variable "health_check_path" {
  description = "Health check path for the load balancer target group"
  type        = string
  default     = "/"
}

# Automatically injected by Terraform
variable "TFC_WORKSPACE_SLUG" {
  type = string
}
