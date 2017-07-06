# Install the cnstechnicalgroup.sqlserver-ag-add-replica role

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
- src: cnstechnicalgroup.sqlserver-ag-add-replica
  name: sqlserver-ag-add-replica
```


## 4. Install the cnstechnicalgroup.sqlserver-server role to ~/cnstechnicalgroup

```bash
ansible-galaxy install -r requirements.yml
```

## 5. cd into sqlserver-ag-add-replica

```bash
cd ~/cnstechnicalgroup/sqlserver-ag-add-replica
```

## 6. Create the inventory file 

```bash
vi inventory
db1 ansible_ssh_host=some_ip_address ansible_ssh_user=vagrant ansible_ssh_private_key_file=~/.ssh/id_rsa
db3 ansible_ssh_host=some_ip_address ansible_ssh_user=vagrant ansible_ssh_private_key_file=~/.ssh/id_rsa

[replicas]
db1
db3


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
vi dbserver_ag_add_replica.yml
```

```yaml
---
- hosts: replicas
  sudo: yes
  roles: 
  - sqlserver-ag-add-replica
  gather_facts: yes
  environment:
   SA_PASSWORD: "{{sa_password}}"

```

## 9. Create a vars directory and add the main.yml file

The primary_host is the primary instance in the Always-On Group.
The secondary_host is the secondary instance in the Always-On Group that will server as the first read-only replica
After this script is run, an Always-On Read-Only Group will be created. From here, you can add databases to the group. 

```bash
mkdir vars
cd vars
vi main.yml
```

```yaml
---
sa_password: "a_Str0ng_Passw0rd1"
availability_group: "ag1"
primary_host: "db1"
secondary_host: "db3"
```


## 10. Run playbook

```bash
ansible-playbook dbserver_ag_add_replica.yml
```


