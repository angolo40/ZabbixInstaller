# ZabbixInstaller

##Agent Version
4.0.5

## Goal
This is simple installer batch help to install zabbix agent on windows machine.
It install agent and open a port on a windows firewall

## Installation

Download this repo:

	git clone https://github.com/angolo40/ZabbixInstaller.git

+ Copy whole directory under c:\zabbix

+ If you want to use Encryption (Recommended):

	+ Change with your PSK KEY (or generate a new one) inside zabbix_agent.psk:
		+ For example, a 256-bit (32 bytes) PSK can be generated using the following commands on Linux: 
		+ openssl rand -hex 32
		+ Read https://www.zabbix.com/documentation/4.0/manual/encryption/using_pre_shared_keys for more option
	+ Run InstallAgent.bat as Administrator
	+ Choose correct option based on your  Windows architecture

+ If you don't want to use Encryption (Not Recommended):

	+ Run InstallAgent.bat as Administrator
	+ Choose correct option based on your Windows architecture

+ Configure Zabbix server:
	+ Read https://www.zabbix.com/documentation/4.0/manual/encryption/using_pre_shared_keys for more option 