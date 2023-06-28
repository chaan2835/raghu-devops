set -x
echo -e "\e[36m########### Configuring nodejs repos #############\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -e "\e[36m########### Installing nodejs #############\e[0m"
yum install nodejs -y

echo -e "\e[36m########### Adding application user #############\e[0m"
useradd roboshop

echo -e "\e[36m########### Creating application dir #############\e[0m"
rm -rf /app
mkdir /app

echo -e "\e[36m########### Downloading app content #############\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip

echo -e "\e[36m########### Changing to app dir #############\e[0m"
cd /app

echo -e "\e[36m########### Unzipping the app content /tmp #############\e[0m"
unzip /tmp/catalogue.zip
cd /app

echo -e "\e[36m########### Installing node modules #############\e[0m"
npm install

echo -e "\e[36m########### Coying catalogue.service to /etc #############\e[0m"
cp catalogue.service /etc/systemd/system/catalogue.service

echo -e "\e[36m########### Reloading daemon #############\e[0m"
systemctl daemon-reload

echo -e "\e[36m########### Enabling the service #############\e[0m"
systemctl enable catalogue

echo -e "\e[36m########### Restarting the service #############\e[0m"
systemctl restart catalogue

echo -e "\e[36m########### Copying the mongo.repo to /etc #############\e[0m"
cp mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[36m########### Installing mongodb client #############\e[0m"
yum install mongodb-org-shell -y

echo -e "\e[36m########### Loading schema #############\e[0m"
mongo --host mongodb.roboshopk8.online </app/schema/catalogue.js