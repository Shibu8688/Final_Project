## Security_Group for Ec2 Instance for SSH and HTTP 
 resource "aws_security_group" "security_group_ec2_g7" {
 count        = var.type == "EC2" ? 1 : 0
  vpc_id      = var.vpc_id
  description = "Security Group for Ec2 Instance"
   # Ingress rule for allowing connection 
 ## HTTP
  ingress {
    description = "HTTP access from specific cidrs"
    from_port   = 80  
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.ingress_cidr
  }
 ## SSH Connection
  ingress {
    description = "SSH access from specific cidrs"
    from_port   = 22  
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.ingress_cidr
  }
  # Egress rule for outgoing connection
      egress {
    description = "Internet access to specific cidr"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.egress_cidr
   }
   
}
 
  
   ## Security_Group for Bastion HostI for SSH and HTTP 
 resource "aws_security_group" "security_group_bastion_g7" {
 count        = var.type == "Bastion" ? 1 : 0
  vpc_id      = var.vpc_id
  description = "Security Group for Bastion Host"
   # Ingress rule for allowing connection 
 # SSH Connection
  ingress {
    description = "SSH access from specific cidrs"
    from_port   = 22  
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.ingress_cidr
  }
  ingress {
    description = "HTTP access from specific cidrs"
    from_port   = 80  
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.ingress_cidr
  }
  # Egress rule for outgoing connection
  egress{
     
    description = "Internet access to specific cidr"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.egress_cidr
   }
}