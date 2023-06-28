echo -e "\e[36m########### Configuring nodejs repos #############\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -e "\e[36m########### Installing nodejs #############\e[0m"
yum install nodejs -y

echo -e "\e[36m########### Adding application user #############\e[0m"
useradd roboshop

echo -e "\e[36m########### creating Application directory #############\e[0m"
rm -rf /app
mkdir /app

echo -e "\e[36m########### updating redis listen address #############\e[0m"
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip
cd /app

echo -e "\e[36m########### Downloading app content #############\e[0m"
unzip /tmp/cart.zip


echo -e "\e[36m########### Installing npm modules #############\e[0m"
npm install

echo -e "\e[36m########### creating application directory #############\e[0m"
cp /home/centos/raghu-devops/learn-shell/roboshop-shell/cart.service /etc/systemd/system/cart.service

echo -e "\e[36m########### Restarting service #############\e[0m"
systemctl daemon-reload
systemctl enable cart
systemctl restart cart