#!/bin/bash
 sudo yum -y update
 sudo yum -y install httpd
 sudo aws s3 cp s3://group19/WhatsApp Image 2023-04-21 at 10.44.09 PM.jpeg  /var/www/html/image
 myip=`hostname -I`
 echo "<h1>Welcome to FInal Project ! private IP is $myip in dev environment </h1> <h2> Name: MAtiRam and Abhiyan and   </h2><br>Built by Terraform! </br>"  >  /var/www/html/index.html
 echo " <img src='image'/>" >>  /var/www/html/index.html
 sudo systemctl start httpd
 sudo systemctl enable httpd