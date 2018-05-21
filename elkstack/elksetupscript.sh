#!/bin/bash

# Script parameters from arguments
elkstack=$1
elkserverstatus=$2
filebeat_status=$3
packetbeat_status=$4
metricbeat_status=$5
nginxservice_status=$6
apache2service_status=$7
mysqlservice_status=$8
HostIP=$(dig +short myip.opendns.com @resolver1.opendns.com)
elkserver=HostIP
elkbeats=HostIP

apt-get update
apt-get install software-properties-common -y
apt-add-repository ppa:ansible/ansible -y
apt-get update
#apt-get install systemd -y
apt-get install ansible -y
apt-get install unzip -y

cd /home/
if [ -e elkstack.* ];
then
  if [ -d /home/elkstack ];
  then
        rm -rf elkstack.*
	rm -rf /home/elkstack
	echo "directory delete"
  fi  
fi

wget $elkstack
unzip elkstack.zip -d /home/elkstack/


## add condition for installing beats and server. 
HOME=/root ansible-playbook /home/elkstack/elkdocker_install.yml  --extra-vars "HostIP=$HostIP elkserver_status=$elkserverstatus filebeat_state=$filebeat_status packetbeat_state=$packetbeat_status metricbeat_state=$metricbeat_status  nginx_state=$nginxservice_status  apache2_state=$apache2service_status mysql_state=$mysqlservice_status" -vvv


