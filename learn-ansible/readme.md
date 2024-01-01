go to the master vm and install ansible using these commands

* sudo labauto (it will show many tool names among those type the tool what we want to install)
    ansible (it'll install ansible automatically)

-----------------------------
ansible --version
ansible [core 2.16.2]
  config file = None
  configured module search path = ['/home/centos/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/local/lib/python3.11/site-packages/ansible
  ansible collection location = /home/centos/.ansible/collections:/usr/share/ansible/collections
  executable location = /usr/local/bin/ansible
  python version = 3.11.5 (main, Oct 25 2023, 14:45:39) [GCC 8.5.0 20210514 (Red Hat 8.5.0-21)] (/usr/bin/python3.11)
  jinja version = 3.1.2
  libyaml = True
--------------------------------
                        Inventory

1)We can keep either IP address or Hostname.

2)Grouping can be done either individual files based on
environment or based on component and even together and that
always depends upon the architecture design that project had.

3)In environments like a cloud where the nodes are too dynamic
and where your IP addresses always change frequently, we need
to work on some dynamic inventory management.
-------------------------------------------------------------------------------------------------

create an sample inventory

vi /tmp/inv
    provide the private ip's

ansible -i  /tmp/inv all -e ansible_user=centos -e ansible_password=DevOps321 -m ansible.builtin.ping

172.31.17.214 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/libexec/platform-python"
    },
    "changed": false,
    "ping": "pong"
}
172.31.23.137 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/libexec/platform-python"
    },
    "changed": false,
    "ping": "pong"
}
