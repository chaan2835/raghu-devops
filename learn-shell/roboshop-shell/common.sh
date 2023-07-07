app_user=roboshop
script=$(realpath "$0")
script_path=$(dirname "$script")

heading_func(){
    echo -e "\e[36m########### $1 #############\e[0m"
}

schema_setup_func(){
    heading_func "Copying the mongo.repo to /etc"
    cp /home/centos/raghu-devops/learn-shell/roboshop-shell/mongo.repo /etc/yum.repos.d/mongo.repo

    heading_func "Installing mongodb client"
    yum install mongodb-org-shell -y

    heading_func "Loading schema--->{component}"
    mongo --host mongodb.roboshopk8.online </app/schema/${component}.js
}

func_nodejs(){

    heading_func "Configuring nodejs repos"
    curl -sL https://rpm.nodesource.com/setup_lts.x | bash

    heading_func "Installing nodejs"
    yum install nodejs -y

    heading_func "Adding application user"
    useradd ${app_user}

    heading_func "creating Application directory"
    rm -rf /app
    mkdir /app

    heading_func "updating redis listen address"
    curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip
    cd /app

    heading_func "Downloading app content"
    unzip /tmp/${component}.zip

    heading_func "Installing npm modules"
    npm install

    heading_func "creating Aplication directory"
    cp ${script_path}/${component}.service /etc/systemd/system/${component}.service

    heading_func "Restarting ${component}-service"
    systemctl daemon-reload
    systemctl enable ${component}
    systemctl restart ${component}
    schema_setup_func
}