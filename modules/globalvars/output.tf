# Default tags for output
output "default_tags" {
  value = {
    "Owner" = "Matiram"
    "App"   = "Web"
    "StudentIds"= "138394226"
  }
}

# Prefix to identify the Group For the Project
output "prefix" {
  value     = "Final-Project"
}

#output of public ip
data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

output "public_ip_cloud9" {
  value = "${chomp(data.http.myip.body)}"
}

data "http" "mypriip" {
  url = "http://169.254.169.254/latest/meta-data/local-ipv4"
  }
  
output "private_cloud9_ip" {
   value =  "${chomp(data.http.mypriip.body)}"
   }
   
output "my_system_ip" {
  value = "174.91.172.73"
}   