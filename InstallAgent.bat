ECHO off
cls
echo. 
echo. 
echo. 
echo.
echo *****************************************************
echo *               Installazione Zabbix                *
echo * Assicurati di avere scompattato zabbix.zip in c:\ *
echo *****************************************************
echo. 
echo. 
echo.
:start
ECHO.
set hostname=
set /p hostname=Inserisci FQDN macchina: 
ECHO.
ECHO.
set serverpassive=
set /p serverpassive=Inserisci IP server Passive: 
ECHO.
ECHO.
set serveractive=
set /p serveractive=Inserisci IP server Active: 
ECHO.
ECHO.
ECHO 0. Installa Zabbix per versioni a Win 64 bit No SSL
ECHO 1. Installa Zabbix per versioni a Win 32 bit No SSL
ECHO 2. Installa Zabbix per versioni a Win 64 bit con SSL PSK
ECHO 3. Installa Zabbix per versioni a Win 32 bit con SSL PSK
ECHO 4. Disinstalla Zabbix per versioni a Win 64 bit
ECHO 5. Disinstalla Zabbix per versioni a Win 32 bit
set choice=
set /p choice=Seleziona la versione da installare (0,1,2,3,4,5):   
if not '%choice%'=='' set choice=%choice:~0,1%
if '%choice%'=='0' goto X64_NOSSL
if '%choice%'=='1' goto X32_NOSSL
if '%choice%'=='2' goto X64_SSL
if '%choice%'=='3' goto X32_SSL
if '%choice%'=='4' goto UninstallX64
if '%choice%'=='5' goto UninstallX32
ECHO "%choice%" Scelta non valida.
ECHO.
goto start

:X64_NOSSL
copy c:\zabbix\zabbix_agentd.conf c:\zabbix_agentd.conf
c:\zabbix\fart.exe -q c:\zabbix_agentd.conf "Hostname=Windows host" "Hostname=%hostname%"
c:\zabbix\fart.exe -q c:\zabbix_agentd.conf "Server=127.0.0.1" "Server=%serverpassive%"
c:\zabbix\fart.exe -q c:\zabbix_agentd.conf "ServerActive=127.0.0.1" "ServerActive=%serveractive%"
cd c:\zabbix\zabbix_agents-4.0.5-win\bin\win64
zabbix_agentd.exe --install
echo
NET START "Zabbix Agent"
del c:\zabbix.zip

goto CreateFirewallRule

:X32_NOSSL
copy c:\zabbix\zabbix_agentd.conf c:\zabbix_agentd.conf
c:\zabbix\fart.exe -q c:\zabbix_agentd.conf "Hostname=Windows host" "Hostname=%hostname%"
c:\zabbix\fart.exe -q c:\zabbix_agentd.conf "Server=127.0.0.1" "Server=%serverpassive%"
c:\zabbix\fart.exe -q c:\zabbix_agentd.conf "ServerActive=127.0.0.1" "ServerActive=%serveractive%"
cd c:\zabbix\zabbix_agents-4.0.5-win\bin\win32
zabbix_agentd.exe --install
echo
NET START "Zabbix Agent"
del c:\zabbix.zip

goto CreateFirewallRule

:X64_SSL
copy c:\zabbix\zabbix_agentd.conf.ssl c:\zabbix_agentd.conf
c:\zabbix\fart.exe -q c:\zabbix_agentd.conf "Hostname=Windows host" "Hostname=%hostname%"
c:\zabbix\fart.exe -q c:\zabbix_agentd.conf "Server=127.0.0.1" "Server=%serverpassive%"
c:\zabbix\fart.exe -q c:\zabbix_agentd.conf "ServerActive=127.0.0.1" "ServerActive=%serveractive%"
cd c:\zabbix\zabbix_agents-4.0.5-win_ssl\bin\win64
zabbix_agentd.exe --install
echo
NET START "Zabbix Agent"
del c:\zabbix.zip

goto CreateFirewallRule

:X32_SSL
copy c:\zabbix\zabbix_agentd.conf.ssl c:\zabbix_agentd.conf
c:\zabbix\fart.exe -q c:\zabbix_agentd.conf "Hostname=Windows host" "Hostname=%hostname%"
c:\zabbix\fart.exe -q c:\zabbix_agentd.conf "Server=127.0.0.1" "Server=%serverpassive%"
c:\zabbix\fart.exe -q c:\zabbix_agentd.conf "ServerActive=127.0.0.1" "ServerActive=%serveractive%"
cd c:\zabbix\zabbix_agents-4.0.5-win_ssl\bin\win32
zabbix_agentd.exe --install
echo
NET START "Zabbix Agent"
del c:\zabbix.zip

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
set PORT=10050
set RULE_NAME="Zabbix %PORT%"

netsh advfirewall firewall show rule name=%RULE_NAME% >nul
if not ERRORLEVEL 1 (
    rem Rule %RULE_NAME% already exists.
    echo Attenzione,non creo la regola su win firewall perche' esiste gia' con questo nome.
) else (
    echo La regola %RULE_NAME% non esiste. Procedo alla creazione.
    netsh advfirewall firewall add rule name=%RULE_NAME% dir=in action=allow protocol=TCP localport=%PORT%
    Echo Regola win firewall creata correttamente 
)
goto end

:end
Pause
