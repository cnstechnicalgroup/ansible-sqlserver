# Install the cnstechnicalgroup.sqlserver-client role

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
- src: cnstechnicalgroup.sqlserver-client
  name: sqlserver-client
```


## 4. Install the cnstechnicalgroup.sqlserver-client role to ~/cnstechnicalgroup

```bash
ansible-galaxy install -r requirements.yml
```

## 5. cd into sqlserver-client

```bash
cd ~/cnstechnicalgroup/sqlserver-client
```

## 6. Create the inventory file 

```bash
vi inventory
db1 ansible_ssh_host=some_ip_address ansible_ssh_user=vagrant ansible_ssh_private_key_file=~/.ssh/id_rsa
```

## 7. Create the ansible.cfg file

```bash
vi ansible.cfg 
```

```bash
[defaults]
roles_path = ~/cnstechnicalgroup
hostfile = inventory
```

## 8. Create the playbook

```bash
vi dbclient.yml
```

```yaml
---
- hosts: db1
  sudo: yes
  roles: 
    - sqlserver-client
  gather_facts: yes
  environment:
    target_home: "{{target_home}}"
    ACCEPT_EULA: "Y"
```
	
## 9. Run playbook

```bash
ansible-playbook dbclient.yml
```


