echo -e "\e[36m########### Installing python #############\e[0m"
yum install python36 gcc python3-devel -y

echo -e "\e[36m########### Adding application user #############\e[0m"
useradd roboshop

echo -e "\e[36m########### creating application directory #############\e[0m"
rm -rf /app
mkdir /app

echo -e "\e[36m########### Downloading app content #############\e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip
cd /app

echo -e "\e[36m########### Extracting service files #############\e[0m"
unzip /tmp/payment.zip

echo -e "\e[36m########### Installing dependencies #############\e[0m"
pip3.6 install -r requirements.txt

echo -e "\e[36m###########  settingup systemd service #############\e[0m"
cp /home/centos/raghu-devops/learn-shell/roboshop-shell/payment.service /etc/systemd/system/payment.service

echo -e "\e[36m########### Restarting service #############\e[0m"
systemctl daemon-reload
systemctl enable payment
systemctl restart payment