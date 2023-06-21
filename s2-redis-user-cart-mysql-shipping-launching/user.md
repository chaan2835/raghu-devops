05-User
User is a microservice that is responsible for User Logins and Registrations Service in RobotShop e-commerce portal.

HINT
Developer has chosen NodeJs, Check with developer which version of NodeJS is needed. Developer has set a context that it can work with NodeJS >18

Setup NodeJS repos. Vendor is providing a script to setup the repos.
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

Install NodeJS
yum install nodejs -y

Configure the application. Here
Add application User
useradd roboshop

Lets setup an app directory.
mkdir /app 

Download the application code to created app directory.
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip 
cd /app 
unzip /tmp/user.zip

Every application is developed by development team will have some common softwares that they use as libraries. This application also have the same way of defined dependencies in the application configuration.
Lets download the dependencies.
cd /app 
npm install 

We need to setup a new service in systemd so systemctl can manage this service
Setup SystemD User Service

vi /etc/systemd/system/user.service
    [Unit]
    Description = User Service
    [Service]
    User=roboshop
    Environment=MONGO=true
    Environment=REDIS_HOST=<REDIS-SERVER-IP>
    Environment=MONGO_URL="mongodb://<MONGODB-SERVER-IP-ADDRESS>:27017/users"
    ExecStart=/bin/node /app/server.js
    SyslogIdentifier=user

    [Install]
    WantedBy=multi-user.target

::hint RECAP You can create file by using vim /etc/systemd/system/user.service :::
Load the service.
systemctl daemon-reload

Start the service.
systemctl enable user 
systemctl start user

check the logs 
tail /var/log/messages
Jun 20 17:01:35 ip-172-31-18-61 user[5382]: {"level":"info","time":1687280495160,"pid":5382,"hostname":"ip-172-31-18-61.ec2.internal","msg":"Redis READY undefined","v":1}
Jun 20 17:01:35 ip-172-31-18-61 user[5382]: {"level":"info","time":1687280495171,"pid":5382,"hostname":"ip-172-31-18-61.ec2.internal","msg":"MongoDB connected","v":1}

For the application to work fully functional we need to load schema to the Database. Then
We need to load the schema. To load schema we need to install mongodb client.
To have it installed we can setup MongoDB repo and install mongodb-client

vi /etc/yum.repos.d/mongo.repo
    [mongodb-org-4.2]
    name=MongoDB Repository
    baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/4.2/x86_64/
    gpgcheck=0
    enabled=1

yum install mongodb-org-shell -y

Load Schema
mongo --host MONGODB-SERVER-IPADDRESS </app/schema/user.js