script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh

echo -e "\e[36m########### Installing python #############\e[0m"
yum install python36 gcc python3-devel -y

echo -e "\e[36m########### Adding application user #############\e[0m"
useradd ${app_user}

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
cp ${script_path}/payment.service /etc/systemd/system/payment.service

echo -e "\e[36m########### Restarting service #############\e[0m"
systemctl daemon-reload
systemctl enable payment
systemctl restart payment