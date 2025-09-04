data "hcp_packer_artifact" "this" {
  bucket_name  = "example-app-3"
  channel_name = "dev"
  platform     = "aws"
  region       = var.aws_region
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}
