# Install the cnstechnicalgroup.sqlserver-ag-config role

This script will configure an Always-On Group with one primary and one secondary read-only instance. Once completed, you can add databases to the group.

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
- src: cnstechnicalgroup.sqlserver-ag-config
  name: cnstechnicalgroup.sqlserver-ag-config
```


## 4. Install the cnstechnicalgroup.sqlserver-server role to ~/cnstechnicalgroup

```bash
ansible-galaxy install -r requirements.yml
```

## 5. cd into sqlserver-ag-config

```bash
cd ~/cnstechnicalgroup/sqlserver-ag-config
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
  sudo: no
  roles: 
    - cnstechnicalgroup.sqlserver-ag-config
  gather_facts: yes
```

## 9. Create a vars directory and add the main.yml file

The primary_host is the primary instance in the Always-On Group.
The secondary_host is the secondary instance in the Always-On Group that will serve as the first read-only replica

```bash
mkdir vars
cd vars
vi main.yml
```

```yaml
---
availability_group: "ag1"
primary_host: "db1"
secondary_host: "db2"
```


## 10. Run playbook

```bash
ansible-playbook dbserver_ag.yml
```


