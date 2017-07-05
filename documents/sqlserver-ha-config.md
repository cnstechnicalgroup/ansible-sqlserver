# Install the cnstechnicalgroup.sqlserver-ha-config role

## 1. Create a directory cnstechnicalgroup_install and cd into it

```bash
mkdir ~/cnstechnicalgroup_install
cd ~/cnstechnicalgroup_install
```

## 2. Create the ansible.cfg file

```bash
vi ansible.cfg 
```

and paste this information 

```bash
[defaults]
roles_path = ~/cnstechnicalgroup
```

## 3. Create the requirements.yml file and paste this information

```yaml
---
- src: cnstechnicalgroup.sqlserver-ha-config
  name: sqlserver-ha-config
```


## 4. Install the cnstechnicalgroup.sqlserver-server role to ~/cnstechnicalgroup

```bash
ansible-galaxy install -r requirements.yml
```

## 5. cd into sqlserver-ha-config

```bash
cd ~/cnstechnicalgroup/sqlserver-ha-config
```

## 6. Create the inventory file 

```bash
vi inventory
db1 ansible_ssh_host=some_ip_address ansible_ssh_user=vagrant ansible_ssh_private_key_file=~/.ssh/id_rsa
db2 ansible_ssh_host=some_ip_address ansible_ssh_user=vagrant ansible_ssh_private_key_file=~/.ssh/id_rsa

[replicas]
db1
db2


```

## 7. Create the ansible.cfg file

```bash
vi ansible.cfg 
```

```bash
[defaults]
roles_path = ~/cnstechnicalgroup
hostfile = inventory

## 8. Create the playbook

```bash
vi dbserver_ha.yml
```

```yaml
---

- hosts: replicas
  sudo: yes
  roles: 
    - sqlserver-ha-config
  gather_facts: yes
```

## 9. Create a vars directory and add the main.yml file

The primary_host name and ip represent the primary instance in the Always-On Group.
The secondary_host name and ip represent the secondary instance in the Always-On Group that will server as the first read-only replica
After this script is run, the Always-On components will be installed on both servers and the port tcp/5022 will be opened. 

```bash
mkdir vars
cd vars
vi main.yml
```

```yaml
---
use_hosts_file: yes
primary_host_ip: 192.168.33.10
secondary_host_ip: 192.168.33.20
primary_host_name: db1
secondary_host_name: db2
```


## 10. Run playbook

```bash
ansible-playbook dbserver_ha.yml
```

