#!/bin/bash
wget https://repo.zabbix.com/zabbix/5.0/rhel/6/x86_64/zabbix-release-5.0-1.el6.noarch.rpm
rpm -i zabbix-release-5.0-1.el6.noarch.rpm --force
yum clean all
cd /etc/zabbix
rm -rf zabbix_agentd.conf
cd /etc/zabbix/zabbix_agentd.d
rm -rf 2cloud*
yum install zabbix-agent -y
wget https://raw.githubusercontent.com/2cloudtecnologia/Zabbix5/master/Confs/2cloud.conf
echo Insira o hostname do agent:
read hostname
  sed -i "s/Hostname=Zabbix server/Hostname=$hostname/g" /etc/zabbix/zabbix_agentd.conf
  sed -i 's/Server=127.0.0.1/Server=zabbix.2cloud.com.br/g' /etc/zabbix/zabbix_agentd.conf
  sed -i 's/ServerActive=127.0.0.1/ServerActive=zabbix.2cloud.com.br/g' /etc/zabbix/zabbix_agentd.conf
  sed -i 's/# HostMetadata=/HostMetadata=cliente,equinix,centos/g' /etc/zabbix/zabbix_agentd.conf
  echo "zabbix	ALL=(ALL)	NOPASSWD: ALL" >> /etc/sudoers
  service zabbix-agent restart
  systemctl enable zabbix-agent
  cat /etc/zabbix/zabbix_agentd.conf | grep Server=
  cat /etc/zabbix/zabbix_agentd.conf | grep ServerActive=
  tail -f /var/log/zabbix/zabbix_agentd.log