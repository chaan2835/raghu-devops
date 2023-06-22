11-Dispatch
Dispatch is the service which dispatches the product after purchase. It is written in GoLang, So wanted to install GoLang.

HINT
Developer has chosen GoLang, Check with developer which version of GoLang is needed.

Install GoLang
yum install golang -y

Configure the application.
Add application User
useradd roboshop

Lets setup an app directory.
mkdir /app

Download the application code to created app directory.
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip
cd /app
unzip /tmp/dispatch.zip

Every application is developed by development team will have some common softwares that they use as libraries. This application also have the same way of defined dependencies in the application configuration.
Lets download the dependencies & build the software.
We need to setup a new service in systemd so systemctl can manage this service
vi /etc/systemd/system/dispatch.service
    [Unit]
    Description = Dispatch Service
    [Service]
    User=roboshop
    Environment=AMQP_HOST=RABBITMQ-IP
    Environment=AMQP_USER=roboshop
    Environment=AMQP_PASS=roboshop123
    ExecStart=/app/dispatch
    SyslogIdentifier=dispatch

    [Install]
    WantedBy=multi-user.target

Load the service.
systemctl daemon-reload

Start the service.
systemctl enable dispatch
systemctl start dispatch

check the logs
tail /var/log/messages
Jun 22 06:55:33 ip-172-31-87-50 dispatch[9871]: 2023/06/22 06:55:33 Connecting to amqp://roboshop:roboshop123@172.31.91.111:5672/
Jun 22 06:55:33 ip-172-31-87-50 dispatch[9871]: 2023/06/22 06:55:33 Waiting for messages
Jun 22 06:55:33 ip-172-31-87-50 dispatch[9871]: 2023/06/22 06:55:33 Rabbit MQ ready true
Jun 22 06:55:33 ip-172-31-87-50 rsyslogd[838]: imjournal: journal files changed, reloading...  [v8.2102.0-13.el8 try https://www.rsyslog.com/e/0 ]
