
script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh

component=catalogue

func_nodejs

echo -e "\e[36m########### Copying the mongo.repo to /etc #############\e[0m"
cp /home/centos/raghu-devops/learn-shell/roboshop-shell/mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[36m########### Installing mongodb client #############\e[0m"
yum install mongodb-org-shell -y

echo -e "\e[36m########### Loading schema #############\e[0m"
mongo --host mongodb.roboshopk8.online </app/schema/catalogue.js