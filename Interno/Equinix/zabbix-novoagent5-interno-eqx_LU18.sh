#!/bin/bash
cd /tmp
wget https://repo.zabbix.com/zabbix/5.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_5.0-1+bionic_all.deb
dpkg -i zabbix-release_5.0-1+bionic_all.deb
apt update
mkdir /home/scripts
chown zabbix:zabbix -R /home/scripts
chmod 744 -R /home/scripts
cd /home/scripts
wget https://raw.githubusercontent.com/2cloudtecnologia/Zabbix5/master/Scripts/sessions.sh
apt install -y zabbix-agent
chmod 744 *
chown zabbix:zabbix *
cd /etc/zabbix/zabbix_agentd.d
wget https://raw.githubusercontent.com/2cloudtecnologia/Zabbix5/master/Confs/2cloud.conf
echo Insira o hostname do agent:
read hostname
  sed -i "s/Hostname=Zabbix server/Hostname=$hostname/g" /etc/zabbix/zabbix_agentd.conf
  sed -i 's/Server=127.0.0.1/Server=192.168.1.117/g' /etc/zabbix/zabbix_agentd.conf
  sed -i 's/ServerActive=127.0.0.1/ServerActive=192.168.1.117/g' /etc/zabbix/zabbix_agentd.conf
  sed -i 's/# HostMetadata=/HostMetadata=2cloud,interno,equinix,linux,ubuntu/g' /etc/zabbix/zabbix_agentd.conf
  echo "zabbix	ALL=(ALL)	NOPASSWD: ALL" >> /etc/sudoers
  service zabbix-agent restart
  systemctl enable zabbix-agent
  cat /etc/zabbix/zabbix_agentd.conf | grep Server=
  cat /etc/zabbix/zabbix_agentd.conf | grep ServerActive=
  tail -f /var/log/zabbix/zabbix_agentd.log