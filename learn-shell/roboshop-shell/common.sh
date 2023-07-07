app_user=roboshop
script=$(realpath "$0")
script_path=$(dirname "$script")

func_nodejs(){
    echo -e "\e[36m########### Configuring nodejs repos #############\e[0m"
    curl -sL https://rpm.nodesource.com/setup_lts.x | bash

    echo -e "\e[36m########### Installing nodejs #############\e[0m"
    yum install nodejs -y

    echo -e "\e[36m########### Adding application user #############\e[0m"
    useradd ${app_user}

    echo -e "\e[36m########### creating Application directory #############\e[0m"
    rm -rf /app
    mkdir /app

    echo -e "\e[36m########### updating redis listen address #############\e[0m"
    curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip
    cd /app

    echo -e "\e[36m########### Downloading app content #############\e[0m"
    unzip /tmp/${component}.zip


    echo -e "\e[36m########### Installing npm modules #############\e[0m"
    npm install

    echo -e "\e[36m########### creating application directory #############\e[0m"
    cp ${script_path}/${component}.service /etc/systemd/system/${component}.service

    echo -e "\e[36m########### Restarting service #############\e[0m"
    systemctl daemon-reload
    systemctl enable ${component}
    systemctl restart ${component}
}