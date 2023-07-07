script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh

component=user
func_nodejs

echo -e "\e[36m########### copying mongo repo #############\e[0m"
cp /home/centos/raghu-devops/learn-shell/roboshop-shell/mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[36m########### Installing mongo clinet #############\e[0m"
yum install mongodb-org-shell -y

echo -e "\e[36m########### loading schema #############\e[0m"
mongo --host mongodb.roboshopk8.online </app/schema/user.js