create an iam user with admin access (this is not recommandable bcz it shows the creds) so we
create iam role and attach that role to the instance

aws ec2 describe-instances (used to list the instances running the region)


installing aws cli
python3 --version
sudo dnf install python3
sudo dnf install python3-pip
pip3 install awscli --upgrade --user
aws configure

=======================================================
working as a non root user
installation of terraform
https://developer.hashicorp.com/terraform/downloads?product_intent=terraform

sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo yum -y install terraform
===========================================================

all terraform files should ends with .tf

terraform basic commands:

1)init: In this phase it will download all the required provider plugins and also initializes the state file if it is remote

2)plan: It will do what the terraform can do on our code

3) apply: It'll create the actual resources

4) destroy: It'll delete actual resources which we are created