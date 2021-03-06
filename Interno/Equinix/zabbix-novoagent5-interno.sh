#!/bin/bash
mkdir /home/scripts
chown zabbix:zabbix -R /home/scripts
chmod 744 -R /home/scripts
cd /home/scripts
wget https://raw.githubusercontent.com/abnerfk/Scripts-Zabbix/master/Top%205%20processos%20utilizando%20CPU%20e%20RAM%20em%20Linux/Scripts/discovertop5cpu.sh
wget https://raw.githubusercontent.com/abnerfk/Scripts-Zabbix/master/Top%205%20processos%20utilizando%20CPU%20e%20RAM%20em%20Linux/Scripts/discovertop5memory.sh
wget https://raw.githubusercontent.com/abnerfk/Scripts-Zabbix/master/Top%205%20processos%20utilizando%20CPU%20e%20RAM%20em%20Linux/Scripts/sessions.sh
chmod 744 *
chown zabbix:zabbix *
cd /etc/zabbix/zabbix_agentd.d
wget https://raw.githubusercontent.com/abnerfk/Scripts-Zabbix/master/Top%205%20processos%20utilizando%20CPU%20e%20RAM%20em%20Linux/zabbix_agentd.d/2cloud.conf
wget https://raw.githubusercontent.com/abnerfk/Scripts-Zabbix/master/Top%205%20processos%20utilizando%20CPU%20e%20RAM%20em%20Linux/zabbix_agentd.d/monitoring_cpu_memory_process.conf
echo Insira o hostname do agent:
read hostname
  sed -i "s/Hostname=Zabbix server/Hostname=$hostname/g" /etc/zabbix/zabbix_agentd.conf
  sed -i 's/Server=127.0.0.1/Server=192.168.1.117/g' /etc/zabbix/zabbix_agentd.conf
  sed -i 's/ServerActive=127.0.0.1/ServerActive=192.168.1.117/g' /etc/zabbix/zabbix_agentd.conf
  echo "zabbix	ALL=(ALL)	NOPASSWD: ALL" >> /etc/sudoers
  service zabbix-agent restart
  systemctl enable zabbix-agent
  cat /etc/zabbix/zabbix_agentd.conf | grep Server=
  cat /etc/zabbix/zabbix_agentd.conf | grep ServerActive=
  tail -f /var/log/zabbix/zabbix_agentd.log