#!/bin/bash
cd /tmp
wget --no-check-certificate https://repo.zabbix.com/zabbix/5.0/debian/pool/main/z/zabbix-release/zabbix-release_5.0-1+buster_all.deb
dpkg -i zabbix-release_5.0-1+buster_all.deb
apt update
apt install -y zabbix-agent
cd /etc/zabbix/zabbix_agentd.d
wget --no-check-certificate https://raw.githubusercontent.com/2cloudtecnologia/arquivos_publicos/main/2cloud.conf
wget --no-check-certificate https://raw.githubusercontent.com/2cloudtecnologia/arquivos_publicos/main/os.conf -O os.conf
read -p "Tecle enter se o servidor for zabbix.2cloud.com.br, ou insira o IP/FQDN do proxy: `echo $'\n> '`" choice
if [[ -z $choice ]]; then
  server="zabbix.2cloud.com.br"
else
  server=$choice
fi
read -p "Insira o nome do agente: `echo $'\n> '`" hostname
read -p "Insira o hostmetada do agente: `echo $'\n> '`" hostmetada
  sed -i "s/Hostname=Zabbix server/Hostname=$hostname/g" /etc/zabbix/zabbix_agentd.conf
  sed -i "s/Server=127.0.0.1/Server=$server/g" /etc/zabbix/zabbix_agentd.conf
  sed -i "s/ServerActive=127.0.0.1/ServerActive=$server/g" /etc/zabbix/zabbix_agentd.conf
  sed -i "s/# HostMetadata=/HostMetadata=$hostmetada/g" /etc/zabbix/zabbix_agentd.conf
  echo "zabbix	ALL=(ALL)	NOPASSWD: ALL" >> /etc/sudoers
  service zabbix-agent restart
  systemctl enable zabbix-agent
  cat /etc/zabbix/zabbix_agentd.conf | grep Server=
  cat /etc/zabbix/zabbix_agentd.conf | grep ServerActive=
  tail -f /var/log/zabbix/zabbix_agentd.log
