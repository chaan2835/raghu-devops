create an iam user with admin access (this is not recommandable bcz it shows the creds) so we
create iam role and attach that role to the instance

aws ec2 describe-instances (used to list the instances running the region)

=======================================================
working as a non root user
installation of terraform
https://developer.hashicorp.com/terraform/downloads?product_intent=terraform

sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo yum -y install terraform
===========================================================

all terraform files should ends with .tf