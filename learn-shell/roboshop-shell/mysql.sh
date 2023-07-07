script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
my_sql_password=#1
echo -e "\e[36m########### Disabling mysql default version #############\e[0m"
yum module disable mysql -y

echo -e "\e[36m########### copying msql repo file #############\e[0m"
cp ${script_path}/mysql.repo /etc/yum.repos.d/mysql.repo

echo -e "\e[36m########### installing mysql #############\e[0m"
yum install mysql-community-server -y

echo -e "\e[36m########### Restarting mysql #############\e[0m"
systemctl enable mysqld
systemctl restart mysqld

echo -e "\e[36m########### Resetting mysql password #############\e[0m"
mysql_secure_installation --set-root-pass ${my_sql_password}
# mysql -uroot -pRoboShop@1