# Final_Project

#Create a C9 environment in your aws console.
#Create S3 bucket in the aws console named group19 (or can change the s3 variables in config.tf and main.tf where necessary)
#if you want to use your own s3 bucket you should check all config files and main.tf files as well as install_webserver
#you can upload image jpeg image with name group19matiABHI.jpeg to demonstrate the image file loaded from s3. (sudo aws s3 cp s3://group19/group19matiABHI.jpeg  /var/www/html/image is used in install_webserver.sh)
#initialize git on your environment
#git clone using the http link
#then go to dev/network directory and initialize terraform (terraform init, terraform validate, terraform plan, terraform apply)
#now initialize and deploy webserver, goto dev/web then (terraform init, terraform validate, terraform plan, terraform apply)
#
#copy ssh key to bastion vm at public subnet 2. (scp )
#test ssh to the VMs at private server from Bastion
