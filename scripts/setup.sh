#!/bin/bash

apt-get install -y wget python-dev libffi-dev gcc python-pip;
pip install --upgrade pip;
pip install paramiko;
pip install ansible;
