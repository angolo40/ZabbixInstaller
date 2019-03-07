# ZabbixInstaller

## Goal
This is simple installer batch help to install zabbix agent on windows machine.
It install agent and open a port on a windows firewall

## Installation

Download this repo:

	git clone https://github.com/angolo40/ZabbixInstaller.git

+ Copy whole directory under c:\zabbix

+ If you want to use Encryption (Recommended):

	+ Generating your PSK
		For example, a 256-bit (32 bytes) PSK can be generated using the following commands: 
		$ openssl rand -hex 32
		Read https://www.zabbix.com/documentation/4.0/manual/encryption/using_pre_shared_keys for more option
	+ Change key inside zabbix_agent.psk

	+ Run InstallAgent.bat as Administrator
	+ Choose correct option based on your 

+ If you don't want to use Encryption:

	+ Run InstallAgent.bat as Administrator
	+ Choose correct option based on your windows architecture


+ Configure Zabbix server:
	+ Read https://www.zabbix.com/documentation/4.0/manual/encryption/using_pre_shared_keys for more option 