# VPC CIDR range
variable "vpc_cidr" {
  default     = "10.1.0.0/16"
  type        = string
  description = "VPC to host the environment"
}

# Variable to signal the current environment 
variable "env" {
  default     = "dev"
  type        = string
  description = "Deployment Environment"
}


# Instance Profile Name for the LaunchConfig 
variable "iam_instance_profile_name" {
  default     = "LabInstanceProfile"
  type        = string
  description = "Instance Profile Name for the LaunchConfig. It  needs to be created and updated in case this is not present"
}

# Instance type fir the LaunchConfig based on environment
variable "instance_type" {
  default = {
    "prod"    = "t3.medium"
    "staging" = "t3.small"
    "dev"     = "t3.micro"
  }
  description = "Intance types"
}


