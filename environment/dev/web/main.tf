#Fetching networking details from s3
data "terraform_remote_state" "network" { // This is to use Outputs from Remote State
  backend = "s3"
  config = {
    bucket = "group19proj"                               // Bucket from where to GET Terraform State
    key    = "network/terraform.tfstate" // Object name in the bucket to GET Terraform State
    region = "us-east-1"                              // Region where bucket created
  }
}

#Importing global vars module
module "global_variable" {
  source = "../../../modules/globalvars"
}
data "aws_availability_zones" "available" {
  state = "available"
}
#configuring variables for 
# Defining the tags  and variables locally using the modules
locals {
  default_tags       = merge(module.global_variable.default_tags, { "env" = var.env })
  prefix             = module.global_variable.prefix
  name_prefix        = "${local.prefix}-${var.env}"
  keyName            = "ssh_key_${var.env}"
  vpc_id             = data.terraform_remote_state.network.outputs.vpc_id
  public_subnet_ids  = data.terraform_remote_state.network.outputs.public_subnet_ids
  private_subnet_ids = data.terraform_remote_state.network.outputs.private_subnet_ids
  # target             = module.application_loadbalancing.target_full_name
  cloud_pub_ip = module.global_variable.public_ip_cloud9
  cloud_pri_ip = module.global_variable.private_cloud9_ip
  my_pub_ip    = module.global_variable.my_system_ip
}
# Security_Key for Both Bastion and Webserver
resource "aws_key_pair" "web_server" {
  key_name   = "${local.name_prefix}-Dev"
  public_key = file("${path.module}/${local.keyName}.pub")
}
# Data source for AMI id to be passed into the module
data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}




#Module for Security Group for EC2 Instances
module "security_group_EC2" {
  source       = "../../../modules/aws_sg"
  env          = var.env
  type         = "EC2"
  vpc_id       = local.vpc_id
  ingress_cidr = ["${local.my_pub_ip}/32", var.vpc_cidr, "0.0.0.0/0"]
  egress_cidr  = [var.vpc_cidr, "${local.my_pub_ip}/32", "0.0.0.0/0"]
  prefix       = local.prefix
  default_tags = local.default_tags
}


#Creation of Module for Bastion Host Security Group
module "security_group_Bastion" {
  source       = "../../../modules/aws_sg"
  env          = var.env
  type         = "Bastion"
  vpc_id       = local.vpc_id
  ingress_cidr = [var.vpc_cidr, "${local.cloud_pub_ip}/32", "${local.cloud_pri_ip}/32", "0.0.0.0/0"]
  egress_cidr  = [var.vpc_cidr, "${local.cloud_pub_ip}/32", "${local.cloud_pri_ip}/32", "0.0.0.0/0"]
  prefix       = local.prefix
  default_tags = local.default_tags
}
# Create a Launch Configuration


# Adding SSH key to Amazon EC2 and bastion
resource "aws_key_pair" "master_key" {
  key_name   = local.name_prefix
  public_key = file("${path.module}/${local.keyName}.pub")
}


# Creation of EC2_Intance_Private_Subnet
resource "aws_instance" "bastion" {
  count                       = length(local.private_subnet_ids)
  ami                         = data.aws_ami.latest_amazon_linux.id
  instance_type               = lookup(var.instance_type, var.env)
  key_name                    = aws_key_pair.master_key.key_name
  subnet_id                   = local.private_subnet_ids[count.index]
  security_groups             = module.security_group_EC2.Ec2_SG
  associate_public_ip_address = false
  ebs_optimized               = true
  monitoring                  = true
  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }
  root_block_device {
    encrypted = true
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(local.default_tags,
    {
      "Name" = "${local.name_prefix}-VM${count.index + 1}"
    }
  )
}
# Pass the provider configuration to the aws_instance module

module "ec2_instance" {
  source            = "../../../modules/aws_instances"
  env               = var.env
  security_group_id = module.security_group_Bastion.Bastion_SG
  vpc_id            = local.vpc_id
  public_subnets    = local.public_subnet_ids
  key_name          = aws_key_pair.master_key.key_name
  ami_id            = data.aws_ami.latest_amazon_linux.id
  instance_type     = lookup(var.instance_type, var.env)
  prefix            = local.prefix
  default_tags      = local.default_tags
  instance_profile_name = var.iam_instance_profile_name
#  subnet            = local.private_subnet_ids[count.index]
  
}
# Creation of EC2_Intance_Private_Subnet
resource "aws_instance" "remote_ansible" {
  count                       = length(local.private_subnet_ids)
  ami                         = data.aws_ami.latest_amazon_linux.id
  instance_type               = lookup(var.instance_type, var.env)
  key_name                    = aws_key_pair.master_key.key_name
  subnet_id                   = local.public_subnet_ids[count.index + 2]
  security_groups             = module.security_group_EC2.Ec2_SG
  associate_public_ip_address = true
  ebs_optimized               = true
  monitoring                  = true
  
  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }
  root_block_device {
    encrypted = true
  }

  lifecycle {
    create_before_destroy = true
  }
  iam_instance_profile = var.iam_instance_profile_name
  tags = merge(local.default_tags,
    {
      "Name" = "${local.name_prefix}-VM-Ansible${count.index + 2}"
       Owner =  "Ansible"
    }
  )
  }