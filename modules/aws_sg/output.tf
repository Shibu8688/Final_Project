#output of Security Group ID of Ec2 Instance
output  "Ec2_SG" {
    value = aws_security_group.security_group_ec2_g7[*].id
}

#output of security group id for bastion host
output "Bastion_SG" {
    value = aws_security_group.security_group_bastion_g7[*].id
}