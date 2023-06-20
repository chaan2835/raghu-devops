03-Catalogue
Catalogue is a microservice that is responsible for serving the list of items that displays in roboshop application.

HINT
Developer has chosen NodeJs, Check with developer which version of NodeJS is needed. Developer has set a context that it can work with NodeJS >18

Setup NodeJS repos. Vendor is providing a script to setup the repos.
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

Install NodeJS
yum install nodejs -y

Configure the application
We already discussed in Linux basics section that applications should run as nonroot user
Add application User
useradd roboshop

Lets setup an app directory.
mkdir /app

Download the application code to created app directory.
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
cd /app
unzip /tmp/catalogue.zip

Every application is developed by development team will have some common softwares that they use as libraries. This application also have the same way of defined dependencies in the application configuration.
Lets download the dependencies.
cd /app
npm install

We need to setup a new service in systemd so systemctl can manage this service
vi /etc/systemd/system/catalogue.service
    [Unit]
    Description = Catalogue Service

    [Service]
    User=roboshop
    Environment=MONGO=true
    Environment=MONGO_URL="mongodb://<MONGODB-SERVER-IPADDRESS>:27017/catalogue"
    ExecStart=/bin/node /app/server.js
    SyslogIdentifier=catalogue

    [Install]
    WantedBy=multi-user.target

You can create file by using vim /etc/systemd/system/catalogue.service
Ensure you replace <MONGODB-SERVER-IPADDRESS> with IP address

Load the service.
systemctl daemon-reload

Start the service.
systemctl enable catalogue
systemctl start catalogue

to check the logs mongodb is connected or not
tail /var/log/messages
Jun 20 15:27:52 ip-172-31-22-90 catalogue[5455]: {"level":"info","time":1687274872276,"pid":5455,"hostname":"ip-172-31-22-90.ec2.internal","msg":"MongoDB connected","v":1}

For the application to work fully functional we need to load schema to the Database.
Schemas are usually part of application code and developer will provide them as part of development.
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
mongo --host MONGODB-SERVER-IPADDRESS </app/schema/catalogue.js

You need to update catalogue server ip address in frontend configuration. Configuration file is /etc/nginx/default.d/roboshop.conf