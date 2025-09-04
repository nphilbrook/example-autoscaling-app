locals {
  additional_tags = {
    HCPPackerBucket  = "example-app-3"
    HCPPackerChannel = "dev"
  }
}

resource "aws_launch_template" "this" {
  name_prefix   = "${var.name_prefix}-"
  description   = "Launch template for ${var.name_prefix} using HCP Packer AMI"
  image_id      = data.hcp_packer_artifact.this.external_identifier
  instance_type = var.instance_type
  key_name      = var.key_pair_name

  vpc_security_group_ids = [aws_security_group.this.id]

  user_data = base64encode(<<-EOF
#!/bin/bash
/usr/local/bin/update-environment.sh ${var.environment}
EOF
  )

  monitoring {
    enabled = true
  }

  ebs_optimized = true

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "enabled"
  }

  tag_specifications {
    resource_type = "instance"
    tags = merge(local.additional_tags, {
      Name = "${var.name_prefix}-instance"
    })
  }

  tag_specifications {
    resource_type = "volume"
    tags = merge(local.additional_tags, {
      Name = "${var.name_prefix}-volume"
    })
  }

  tags = merge(local.additional_tags, {
    Name = "${var.name_prefix}-launch-template"
  })

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "this" {
  name                      = "${var.name_prefix}-asg"
  vpc_zone_identifier       = data.aws_subnets.default.ids
  target_group_arns         = var.target_group_arns
  health_check_type         = length(var.target_group_arns) > 0 ? "ELB" : "EC2"
  health_check_grace_period = 300

  min_size         = var.min_size
  max_size         = var.max_size
  desired_capacity = var.desired_capacity

  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
      instance_warmup        = 300
    }
    triggers = ["tag"]
  }

  dynamic "tag" {
    for_each = local.additional_tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }

  tag {
    key                 = "Name"
    value               = "${var.name_prefix}-instance"
    propagate_at_launch = true
  }

  wait_for_capacity_timeout = "10m"

  lifecycle {
    create_before_destroy = true
  }
}
