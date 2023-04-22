# Default tags
variable "default_tags" {
  default = {}
  type        = map(any)
  description = "Default tags to be appliad to all AWS resources"
}

# Name prefix
variable "prefix" {
  type        = string
  default     = "Final-Project"
  description = "Name prefix"
}

# Instance type required by the Launch Configuration
variable "instance_type" {
  type        = string
  description = "instance_type for the webserver"
}

# Instance ID 
variable "ami_id" {
  type = string
  description = "AMI ID for the launch_configuration"
}

# creating key pair for ssh connection
variable "key_name" {
  type = string
  description = "Key Name for the launch_configuration"
}

# the Security Group IDs for the LaunchConfig
variable "security_group_id" {
  default     = []
  type        = list(string)
  description = "Security Group ID"
}


#specifying Group Name
variable "env" {
  default     = "dev"
  type        = string
  description = "Deployment Environment"
}
variable "public_subnets" {
  default     = []
  type        = list(string)
  description = "Public Subnet CIDRs"

}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "instance_profile_name" {
  type = string
  description = "IAM Role"
}

variable "instance_count" {
  description = "Number of instances to create"
  default     = 2
}