# Create a VPC
resource "aws_vpc" "main" {
  cidr_block                     = var.vpcidr
  enable_dns_hostnames           = true
  enable_dns_support             = true
  tags = var.project_tags
}
