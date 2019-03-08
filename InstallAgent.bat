ECHO off
cls
echo. 
echo. 
echo. 
echo.
echo *****************************************************
echo * Zabbix Agent Installer batch file on Windows OS   *
echo * Put whole directory in c:\zabbix                  *
echo *****************************************************
echo. 
echo. 
echo.
:start
ECHO.
set hostname=
set /p hostname=insert machine FQDN: 
ECHO.
ECHO.
set serverpassive=
set /p serverpassive=Zabbix Server IP Passive: 
ECHO.
ECHO.
set PORT=
set /p PORT=Zabbix Agent Listen Port[10050]:
IF NOT DEFINED PORT SET "PORT=10050"
ECHO.
ECHO.
set serveractive=
set /p serveractive=Zabbix Server IP Active: 
ECHO.
ECHO.
ECHO 0. Install Zabbix Agent for Win 64 bit No SSL
ECHO 1. Install Zabbix Agent for Win 32 bit No SSL
ECHO 2. Install Zabbix Agent for Win 64 bit with SSL PSK
ECHO 3. Install Zabbix Agent for Win 32 bit with SSL PSK
ECHO 4. Remove Zabbix Agent for Win 64 bit
ECHO 5. Remove Zabbix Agent for Win 32 bit
ECHO.
ECHO.
set choice=
set /p choice=Choose your version (0,1,2,3,4,5):   
if not '%choice%'=='' set choice=%choice:~0,1%
if '%choice%'=='0' goto X64_NOSSL
if '%choice%'=='1' goto X32_NOSSL
if '%choice%'=='2' goto X64_SSL
if '%choice%'=='3' goto X32_SSL
if '%choice%'=='4' goto UninstallX64
if '%choice%'=='5' goto UninstallX32
ECHO "%choice%" No valid choise.
ECHO.
goto start

:X64_NOSSL
copy c:\zabbix\zabbix_agentd.conf c:\zabbix_agentd.conf
c:\zabbix\fart.exe -q c:\zabbix_agentd.conf "Hostname=Windows host" "Hostname=%hostname%"
c:\zabbix\fart.exe -q c:\zabbix_agentd.conf "Server=127.0.0.1" "Server=%serverpassive%"
c:\zabbix\fart.exe -q c:\zabbix_agentd.conf "ServerActive=127.0.0.1" "ServerActive=%serveractive%"
c:\zabbix\fart.exe -q c:\zabbix_agentd.conf "# ListenPort=10050" "ListenPort=%PORT%"
cd c:\zabbix\zabbix_agents-4.0.5-win\bin\win64
zabbix_agentd.exe --install
echo
NET START "Zabbix Agent"

goto CreateFirewallRule

:X32_NOSSL
copy c:\zabbix\zabbix_agentd.conf c:\zabbix_agentd.conf
c:\zabbix\fart.exe -q c:\zabbix_agentd.conf "Hostname=Windows host" "Hostname=%hostname%"
c:\zabbix\fart.exe -q c:\zabbix_agentd.conf "Server=127.0.0.1" "Server=%serverpassive%"
c:\zabbix\fart.exe -q c:\zabbix_agentd.conf "ServerActive=127.0.0.1" "ServerActive=%serveractive%"
c:\zabbix\fart.exe -q c:\zabbix_agentd.conf "# ListenPort=10050" "ListenPort=%PORT%"
cd c:\zabbix\zabbix_agents-4.0.5-win\bin\win32
zabbix_agentd.exe --install
echo
NET START "Zabbix Agent"

goto CreateFirewallRule

:X64_SSL
copy c:\zabbix\zabbix_agentd.conf.ssl c:\zabbix_agentd.conf
c:\zabbix\fart.exe -q c:\zabbix_agentd.conf "Hostname=Windows host" "Hostname=%hostname%"
c:\zabbix\fart.exe -q c:\zabbix_agentd.conf "Server=127.0.0.1" "Server=%serverpassive%"
c:\zabbix\fart.exe -q c:\zabbix_agentd.conf "ServerActive=127.0.0.1" "ServerActive=%serveractive%"
c:\zabbix\fart.exe -q c:\zabbix_agentd.conf "# ListenPort=10050" "ListenPort=%PORT%"
cd c:\zabbix\zabbix_agents-4.0.5-win_ssl\bin\win64
zabbix_agentd.exe --install
echo
NET START "Zabbix Agent"

goto CreateFirewallRule

:X32_SSL
copy c:\zabbix\zabbix_agentd.conf.ssl c:\zabbix_agentd.conf
c:\zabbix\fart.exe -q c:\zabbix_agentd.conf "Hostname=Windows host" "Hostname=%hostname%"
c:\zabbix\fart.exe -q c:\zabbix_agentd.conf "Server=127.0.0.1" "Server=%serverpassive%"
c:\zabbix\fart.exe -q c:\zabbix_agentd.conf "ServerActive=127.0.0.1" "ServerActive=%serveractive%"
c:\zabbix\fart.exe -q c:\zabbix_agentd.conf "# ListenPort=10050" "ListenPort=%PORT%"
cd c:\zabbix\zabbix_agents-4.0.5-win_ssl\bin\win32
zabbix_agentd.exe --install
echo
NET START "Zabbix Agent"

goto CreateFirewallRule


:UninstallX64
NET STOP "Zabbix Agent"
cd c:\zabbix\zabbix_agents-4.0.5-win\bin\win64
zabbix_agentd.exe --uninstall
del c:\zabbix_agentd.conf
del c:\zabbix_agentd.log
goto end

:UninstallX32
NET STOP "Zabbix Agent"
cd c:\zabbix\zabbix_agents-4.0.5-win\bin\win32
zabbix_agentd.exe --uninstall
del c:\zabbix_agentd.conf
del c:\zabbix_agentd.log
goto end

:CreateFirewallRule
set RULE_NAME="Zabbix %PORT%"

netsh advfirewall firewall show rule name=%RULE_NAME% >nul
if not ERRORLEVEL 1 (
    rem Rule %RULE_NAME% already exists.
    echo WARNING, Rule already defined. Rule %RULE_NAME% not created.
) else (
    echo OK - Rule name %RULE_NAME% not exist.
    netsh advfirewall firewall add rule name=%RULE_NAME% dir=in action=allow protocol=TCP localport=%PORT%
    Echo OK - Rule name %RULE_NAME% successfully created.  
)
goto end

:end
Pause
