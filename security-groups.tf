resource "aws_security_group" "this" {
  name_prefix = "${var.name_prefix}-instances-"
  description = "Security group for ${var.name_prefix} autoscaling group instances"
  vpc_id      = data.aws_vpc.default.id

  tags = merge(local.additional_tags, {
    Name = "${var.name_prefix}-instances-sg"
  })
}

resource "aws_vpc_security_group_ingress_rule" "http_from_alb" {
  security_group_id = aws_security_group.this.id
  description       = "HTTP from ALB"

  referenced_security_group_id = aws_security_group.alb.id
  from_port                    = var.app_port
  to_port                      = var.app_port
  ip_protocol                  = "tcp"

  tags = {
    Name = "${var.name_prefix}-http"
  }
}

resource "aws_vpc_security_group_egress_rule" "all" {
  security_group_id = aws_security_group.this.id
  description       = "All outbound traffic"

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"

  tags = {
    Name = "${var.name_prefix}-egress-all"
  }
}
