script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh

echo -e "\e[36m########### Installing maven #############\e[0m"
yum install maven -y

echo -e "\e[36m########### creating app user #############\e[0m"
useradd ${app_user}

echo -e "\e[36m########### creating application directory #############\e[0m"
mkdir /app

echo -e "\e[36m########### Downlaoad app content #############\e[0m"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip

echo -e "\e[36m########### Extract app content #############\e[0m"
cd /app
unzip /tmp/shipping.zip

echo -e "\e[36m########### Downloading maven dependencies #############\e[0m"
mvn clean package
mv target/shipping-1.0.jar shipping.jar

echo -e "\e[36m########### Setting up service file  #############\e[0m"
cp ${script_path}/shipping.service /etc/systemd/system/shipping.service

echo -e "\e[36m########### Installing mysql #############\e[0m"
yum install mysql -y

echo -e "\e[36m########### Loading schema #############\e[0m"
mysql -h mysql.roboshopk8.online -uroot -pRoboShop@1 < /app/schema/shipping.sql

echo -e "\e[36m########### starting service #############\e[0m"
systemctl daemon-reload
systemctl enable shipping
systemctl restart shipping