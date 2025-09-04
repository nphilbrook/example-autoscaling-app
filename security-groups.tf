resource "aws_security_group" "this" {
  name_prefix = "${var.name_prefix}-"
  description = "Security group for ${var.name_prefix} autoscaling group"
  vpc_id      = data.aws_vpc.default.id

  tags = {
    Name = "${var.name_prefix}-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "http" {
  security_group_id = aws_security_group.this.id
  description       = "HTTP"

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  to_port     = 80
  ip_protocol = "tcp"

  tags = {
    Name = "${var.name_prefix}-http"
  }
}

resource "aws_vpc_security_group_ingress_rule" "https" {
  security_group_id = aws_security_group.this.id
  description       = "HTTPS"

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 443
  to_port     = 443
  ip_protocol = "tcp"

  tags = {
    Name = "${var.name_prefix}-https"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ssh" {
  count = var.enable_ssh_access ? 1 : 0

  security_group_id = aws_security_group.this.id
  description       = "SSH"

  cidr_ipv4   = var.ssh_cidr_blocks
  from_port   = 22
  to_port     = 22
  ip_protocol = "tcp"

  tags = {
    Name = "${var.name_prefix}-ssh"
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
