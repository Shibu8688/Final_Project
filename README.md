# Final_Project

#Create a C9 environment in your aws console.

#Create S3 bucket in the aws console named group19proj (or can change the s3 variables in config.tf and main.tf where necessary)

#if you want to use your own s3 bucket you should check all config files and main.tf files as well as install_webserver

#you can upload image jpeg image with name group19matiABHI.jpeg to demonstrate the image file loaded from s3. (sudo aws s3 cp s3://group19proj/group19matiABHI.jpeg  /var/www/html/image is used in install_webserver.sh)

#initialize git on your environment

#git clone using the http link

#then go to dev/network directory and initialize terraform (terraform init, terraform validate, terraform plan, terraform apply)

#now initialize and deploy webserver, goto dev/web then (terraform init, terraform validate, terraform plan, terraform apply)

#VM1 and VM2 are in private subnets

#Amazon-VM0 and Amazon-VM1 are in public subnet 1 and 2 (webservers are configured from userdata and deployed using install_webserver.sh file)

#VM-Ansible2 and VM-Ansible3 are in public subnet 3 and 4 (webservers are yet to be configured and will be deployed using dynamic ansible playbook)

#copy ssh key to bastion vm at public subnet 2 from cloud

#test ssh to all VMs in public subnet using the copied ssh key (Can go to the directory ssh key was copied and establish connection from there)

#test ssh to the VMs at private server from Bastion(VM in public subnet 2)

#test http to all VMs in public subnet (notice vm-ansible2 and vm-ansible3 does not respond to http request)

#go to ansible directory 

#install ansible and boto3

#sudo vi /etc/ansible/ansible.cfg (INSERT FOLLOWING SCRIPT)
  [inventory]
  enable_plugins = aws_ec2

  [defaults]
  remote_user = ec2-user
  private_key_file = /home/ec2-user/environment/Final_Project/ansible/ssh_key_dev
  
#Use ansible commands
  ansible-inventory -i aws_ec2.yaml --graph
  and
  ansible-playbook -i aws_ec2.yaml httpd.yml
  
#Now test the webserver in public subnet 3 and 4
  
 #Finish Remember to destroy all the resources
 #thank you
