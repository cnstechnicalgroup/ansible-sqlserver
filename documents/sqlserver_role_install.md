# Install the cnstechnicalgroup.sqlserver-server role

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
- src: cnstechnicalgroup.sqlserver-server
  name: cnstechnicalgroup.sqlserver-server
```


## 4. Install the cnstechnicalgroup.sqlserver-server role to ~/cnstechnicalgroup

```bash
ansible-galaxy install -r requirements.yml
```


## 5. cd into sqlserver-server

```bash
cd ~/cnstechnicalgroup/sqlserver-server
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
vi dbserver.yml
```

```yaml
---
- hosts: db1
  sudo: yes
  roles: 
    - cnstechnicalgroup.sqlserver-server
  gather_facts: yes
  environment:
    SA_PASSWORD: "{{sa_password}}"
```

## 9. Create a vars directory and add the main.yml file

```bash
mkdir vars
cd vars
vi main.yml
```

```yaml
---
sa_password: "a_Str0ng_Passw0rd1"
```

## 10. Run playbook

```bash
ansible-playbook dbserver.yml
```


