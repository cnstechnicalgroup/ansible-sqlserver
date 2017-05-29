# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|


 config.vm.provider "virtualbox" do |v|
     v.memory = 4096
     v.cpus = 4 
 end


 config.vm.define "db1" do |db1|
   db1.vm.box = "geerlingguy/centos7"
   db1.vm.hostname = "db1"
   db1.vm.network "private_network", ip: "192.168.33.10"
 end

 config.vm.define "db2" do |db2|
   db2.vm.box = "geerlingguy/centos7"
   db2.vm.hostname = "db2"
   db2.vm.network "private_network", ip: "192.168.33.20"
 end


 config.vm.define "acs" do |acs|
   acs.vm.box = "geerlingguy/centos7"
   acs.vm.hostname = "acs"
   acs.vm.network "private_network", ip: "192.168.33.30"

 	config.vm.provider "virtualbox" do |v|
	     v.memory = 1024
	     v.cpus = 2
	 end
 end

end
