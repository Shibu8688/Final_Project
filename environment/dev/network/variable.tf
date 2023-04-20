# Default tags
variable "default_tags" {
  default = {
    "Owner" = "Matiram-Abhi",
    "App"   = "Web"
  }
  type        = map(any)
  description = "Default tags to be appliad to all AWS resources"
}

# Name prefix
variable "prefix" {
  default     = "Final project"
  type        = string
  description = "Name prefix"
}
#Provision for Public_Subnet
variable "public_subnet_cidrs" {
  default     = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24", "10.1.4.0/24"]
  description = "Public Subnet CIDRs"
  }
#Provision for Private_Subnet
variable "private_subnet_cidrs" {
  default     = ["10.1.5.0/24", "10.1.6.0/24"]
  description = "Private Subnet CIDRs"

}
# VPC CIDR range
variable "vpc_cidr" {
  default     = "10.1.0.0/16"
  type        = string
  description = "VPC to host static web site"
}

# Variable to signal the current environment 
variable "env" {
  default     = "dev"
  type        = string
  description = "Deployment Environment"
}