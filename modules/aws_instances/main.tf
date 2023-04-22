### Module to Create a AWS Instances

# Step 1 - Define the provider
provider "aws" {
  region = "us-east-1"
  
  
  
}

# Data source for availability zones in us-east-1
data "aws_availability_zones" "available" {
  state = "available"
}

# Local variables
locals {
  default_tags = merge(
    var.default_tags,
    { "Env" = var.env }
  )
  name_prefix = "${var.prefix}-${var.env}"
}

# Instance configuration 
resource "aws_instance" "ec2_instance" {
  security_groups             = var.security_group_id
  count                       = var.instance_count
  key_name                    = var.key_name
  ami                         = var.ami_id
  subnet_id                   = var.public_subnets[count.index]
  iam_instance_profile        = var.instance_profile_name
  instance_type               = var.instance_type
  associate_public_ip_address = true
  user_data                   = file("${path.module}/install_webserver.sh")
  root_block_device {
    encrypted = true
  }
  tags = {
    Name = "${local.name_prefix}-Amazon-VM-${count.index}"
  }
}
