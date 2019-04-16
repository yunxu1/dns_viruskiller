@echo off
CHCP 437
echo check service
sc stop Ddriver
sc delete Ddriver
sc stop RemComSvc
sc delete RemComSvc
sc stop WebServers
sc delete WebServers
sc stop DnsScan
sc delete DnsScan
echo Stop Malicious Services

echo Del Hacker User
net user k8h3d /del

echo Delete scheduled tasks

schtasks /End /tn "Ddrivers"
schtasks /End /tn "DnsScan"
schtasks /End /tn "Autoscan" 
schtasks /End /tn "Autocheck" 
schtasks /End /tn "net restart" 
schtasks /End /tn "WebServers" 
schtasks /End /tn "Credentials" 
schtasks /End /tn "\Microsoft\Credentials" 
schtasks /End /tn "\Microsoft\windows\Bluetooths" 
schtasks /End /tn "\Microsoft\windows\csro"
schtasks /End /tn "\Microsoft\windows\Rass"
schtasks /delete /tn "Ddrivers" /f
schtasks /delete /tn "DnsScan" /f
schtasks /delete /tn "Autoscan" /f
schtasks /delete /tn "Autocheck" /f
schtasks /delete /tn "net restart" /f
schtasks /delete /tn "WebServers" /f
schtasks /delete /tn "Credentials" /f
schtasks /delete /tn "\Microsoft\Credentials" /f
schtasks /delete /tn "\Microsoft\windows\Bluetooths" /f
schtasks /delete /tn "\Microsoft\windows\csro" /f
schtasks /delete /tn "\Microsoft\windows\Rass" /f

echo end powershell backdoor
for /f "tokens=2 delims=," %%a in ('schtasks /query /v /FO CSV ^| findstr /i /r "powershell"') do schtasks /End /tn %%a 
for /f "tokens=2 delims=," %%a in ('schtasks /query /v /FO CSV ^| findstr /i /r "windows\\temp"') do schtasks /End /tn %%a 
echo Delete powershell backdoor
for /f "tokens=2 delims=," %%a in ('schtasks /query /v /FO CSV ^| findstr /i /r "powershell"') do schtasks /delete /tn %%a /f
for /f "tokens=2 delims=," %%a in ('schtasks /query /v /FO CSV ^| findstr /i /r "windows\\temp"') do schtasks /delete /tn %%a /f
echo Delete powershell Done

echo Delete registry
reg delete HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /v WebServers /f
reg delete HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /v Ddriver /f


echo End process
wmic process where "name='svchost.exe' and ExecutablePath<>'C:\\WINDOWS\\system32\\svchost.exe'" call Terminate
wmic process where "name='taskmgr.exe' and ExecutablePath<>'C:\\WINDOWS\\system32\\taskmgr.exe'" call Terminate
wmic process where "name='svchost.exe' and ExecutablePath='C:\\windows\\SysWOW64\\drivers\\svchost.exe'" call Terminate
wmic process where "name='taskmgr.exe' and ExecutablePath='C:\\windows\\SysWOW64\\drivers\\taskmgr.exe'" call Terminate
wmic process where "name='wmiex.exe'" call Terminate
wmic process where "name='updater.exe' and ExecutablePath='C:\\Windows\\temp\\updater.exe '" call Terminate
wmic process where "name='updll.exe' and ExecutablePath<>'c:\\windows\\temp\\updll.exe'" call Terminate
wmic process where "name='setup-install.exe' and ExecutablePath<>'c:\\windows\\temp\\setup-install.exe'" call Terminate
wmic process where "name='tmp.vbs' and ExecutablePath<>'c:\\windows\\temp\\tmp.vbs'" call Terminate
wmic process where "name='ttt.exe' and ExecutablePath<>'c:\\windows\\temp\\ttt.exe'" call Terminate


echo Delete files
wmic datafile where "drive='c:' and Path='\\windows\\temp\\' and FileName='updater' and Extension='exe'" call delete
wmic datafile where "drive='c:' and Path='\\windows\\temp\\' and FileName='m' and Extension='ps1'" call delete
wmic datafile where "drive='c:' and Path='\\windows\\temp\\' and FileName='mkatz' and Extension='ini'" call delete
wmic datafile where "drive='c:' and Path='\\windows\\temp\\' and FileName='svchost' and Extension='exe'" call delete
wmic datafile where "drive='c:' and Path='\\windows\\system32\\drivers\\' and FileName='svchost' and Extension='exe'" call delete
wmic datafile where "drive='c:' and Path='\\windows\\system32\\drivers\\' and FileName='taskmgr' and Extension='exe'" call delete
wmic datafile where "drive='c:' and Path='\\windows\\system32\\' and FileName='wmiex' and Extension='exe'" call delete
wmic datafile where "drive='c:' and Path='\\windows\\SysWOW64\\drivers\\' and FileName='svchost' and Extension='exe'" call delete
wmic datafile where "drive='c:' and Path='\\windows\\SysWOW64\\drivers\\' and FileName='taskmgr' and Extension='exe'" call delete
wmic datafile where "drive='c:' and Path='\\windows\\SysWOW64\\' and FileName='wmiex' and Extension='exe'" call delete
wmic datafile where "drive='c:' and Path='\\windows\\temp\\' and FileName='updll' and Extension='exe'" call delete
wmic datafile where "drive='c:' and Path='\\windows\\temp\\' and FileName='setup-install' and Extension='exe'" call delete
wmic datafile where "drive='c:' and Path='\\windows\\temp\\' and FileName='tmp.vbs' and Extension='exe'" call delete
wmic datafile where "drive='c:' and Path='\\windows\\temp\\' and FileName='ttt.exe' and Extension='exe'" call delete


echo Stop services
wmic service where "PathName like '%%net share C$=C:%%'" call Terminate
wmic service where "PathName like '%%net share C$=C:%%'" call delete


echo Close port forwarding
netsh interface portproxy delete v4tov4 listenport=65531
netsh interface portproxy delete v4tov4 listenport=65532

echo Finish
