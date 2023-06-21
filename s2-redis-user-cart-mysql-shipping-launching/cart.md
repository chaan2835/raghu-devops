06-Cart
Cart is a microservice that is responsible for Cart Service in RobotShop e-commerce portal.

HINT
Developer has chosen NodeJs, Check with developer which version of NodeJS is needed.

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
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip
cd /app
unzip /tmp/cart.zip

Every application is developed by development team will have some common softwares that they use as libraries. This application also have the same way of defined dependencies in the application configuration.
Lets download the dependencies.
cd /app
npm install

We need to setup a new service in systemd so systemctl can manage this service
vi /etc/systemd/system/cart.service
    [Unit]
    Description = Cart Service
    [Service]
    User=roboshop
    Environment=REDIS_HOST=<REDIS-SERVER-IP>
    Environment=CATALOGUE_HOST=<CATALOGUE-SERVER-IP>
    Environment=CATALOGUE_PORT=8080
    ExecStart=/bin/node /app/server.js
    SyslogIdentifier=cart

    [Install]
    WantedBy=multi-user.target

Load the service.
systemctl daemon-reload

Start the service.
systemctl enable cart
systemctl start cart

check the logs
tail /var/log/messages
Jun 21 13:24:43 ip-172-31-80-94 cart[5367]: {"level":"info","time":1687353883117,"pid":5367,"hostname":"ip-172-31-80-94.ec2.internal","msg":"Redis READY undefined","v":1}