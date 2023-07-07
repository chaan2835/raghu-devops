script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
rabbitmq_password=#1

echo -e "\e[36m########### Setting up erlang repos #############\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash

echo -e "\e[36m########### Setting up rabbitmq repos #############\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash

echo -e "\e[36m########### Installing erlang & rabbitmq #############\e[0m"
yum install erlang rabbitmq-server -y

echo -e "\e[36m########### Restarting service #############\e[0m"
systemctl enable rabbitmq-server
systemctl restart rabbitmq-server

echo -e "\e[36m########### Adding application user in Rabbitmq #############\e[0m"
rabbitmqctl add_user roboshop ${rabbitmq_password}
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"