#!/bin/bash

yum install -y yum-utils;
yum-config-manager --add-repo=https://dl.fedoraproject.org/pub/epel/7/x86_64/;
yum install -y wget;
wget -O /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7 https://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7;
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7;
yum install -y python-devel libffi-devel openssl-devel gcc python-pip redhat-rpm-config;
pip install --upgrade pip;
pip install paramiko;
pip install ansible;
mkdir /home/vagrant;
