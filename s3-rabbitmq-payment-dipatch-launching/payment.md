10-Payment
This service is responsible for payments in RoboShop e-commerce app. This service is written on Python 3.6, So need it to run this app.

HINT
Developer has chosen Python, Check with developer which version of Python is needed.
Install Python 3.6
yum install python36 gcc python3-devel -y

Configure the application.
Add application User
useradd roboshop

Lets setup an app directory.
mkdir /app

Download the application code to created app directory.
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip
cd /app
unzip /tmp/payment.zip

Every application is developed by development team will have some common softwares that they use as libraries. This application also have the same way of defined dependencies in the application configuration.
Lets download the dependencies.
cd /app
pip3.6 install -r requirements.txt

We need to setup a new service in systemd so systemctl can manage this service
vi /etc/systemd/system/payment.service
    [Unit]
    Description=Payment Service

    [Service]
    User=root
    WorkingDirectory=/app
    Environment=CART_HOST=<CART-SERVER-IPADDRESS>
    Environment=CART_PORT=8080
    Environment=USER_HOST=<USER-SERVER-IPADDRESS>
    Environment=USER_PORT=8080
    Environment=AMQP_HOST=<RABBITMQ-SERVER-IPADDRESS>
    Environment=AMQP_USER=roboshop
    Environment=AMQP_PASS=roboshop123

    ExecStart=/usr/local/bin/uwsgi --ini payment.ini
    ExecStop=/bin/kill -9 $MAINPID
    SyslogIdentifier=payment

    [Install]
    WantedBy=multi-user.target

Load the service.
systemctl daemon-reload

Start the service.
systemctl enable payment
systemctl start payment

check the logs
tail /var/log/messages
Jun 22 06:40:53 ip-172-31-87-120 payment[5846]: WSGI app 0 (mountpoint='') ready in 1 seconds on interpreter 0x1dd4520 pid: 5846 (default app)