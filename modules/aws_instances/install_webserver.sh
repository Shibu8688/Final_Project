#!/bin/bash
 sudo yum -y update
 sudo yum -y install httpd
 sudo aws s3 cp s3://group19/group19matiABHI.jpeg  /var/www/html/image
 myip=`hostname -I`
 echo "<h1>Welcome to FInal Project ! private IP is $myip in dev environment </h1> <h2> Name: MAtiRam and Abhiyan and   </h2><br>Built by Terraform! </br>"  >  /var/www/html/index.html
 echo " <img src='image'/>" >>  /var/www/html/index.html
 sudo systemctl start httpd
 sudo systemctl enable httpd