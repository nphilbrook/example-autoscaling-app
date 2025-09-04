provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment        = var.environment
      Project            = var.name_prefix
      "created-by"       = "terraform"
      "source-workspace" = var.TFC_WORKSPACE_SLUG
    }
  }
}

provider "hcp" {
  # Authentication is handled via environment variables or workspace configuration
}
