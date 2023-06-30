source common.sh

echo -e "\e[36m########### Configuring nodejs repos #############\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -e "\e[36m########### Installing nodejs #############\e[0m"
yum install nodejs -y

echo -e "\e[36m########### Adding application user #############\e[0m"
useradd ${app_user}

echo -e "\e[36m########### creating Application directory #############\e[0m"
mkdir /app

echo -e "\e[36m########### updating redis listen address #############\e[0m"
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip
cd /app

echo -e "\e[36m########### Downloading app content #############\e[0m"
unzip /tmp/user.zip
cd /app

echo -e "\e[36m########### Installing npm modules #############\e[0m"
npm install

echo -e "\e[36m########### creating application directory #############\e[0m"
cp /home/centos/raghu-devops/learn-shell/roboshop-shell/user.service /etc/systemd/system/user.service

echo -e "\e[36m########### Restarting service #############\e[0m"
systemctl daemon-reload
systemctl enable user
systemctl restart user

echo -e "\e[36m########### copying mongo repo #############\e[0m"
cp /home/centos/raghu-devops/learn-shell/roboshop-shell/mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[36m########### Installing mongo clinet #############\e[0m"
yum install mongodb-org-shell -y

echo -e "\e[36m########### loading schema #############\e[0m"
mongo --host mongodb.roboshopk8.online </app/schema/user.js