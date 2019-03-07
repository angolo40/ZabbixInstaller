# ZabbixInstaller

## Goal
This is simple installer help to install zabbix agent on windows machine.
It install agent and open a port on a windows firewall

## Installation

Download this repo:

	git clone https://github.com/angolo40/ZabbixInstaller.git

Copy whole directory under c:\zabbix

If you want to use Encryption
Generating your PSK

For example, a 256-bit (32 bytes) PSK can be generated using the following commands: 
openssl rand -hex 32

Read https://www.zabbix.com/documentation/4.0/manual/encryption/using_pre_shared_keys for more option

change key inside zabbix_agent.psk

run InstallAgent.bat as Administrator