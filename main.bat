@echo off
net session >nul 2>&1
if %errorLevel% == 0 (
    goto :admin
) else (
    goto :notadmin
)
:admin
echo Running as admin
echo "Do you want to 1. Enable or 2. Disable FSM?"
set /p choice=Type 1 or 2 then press ENTER:
if %choice% == 1 goto :enable
if %choice% == 2 goto :disable
:enable
schtasks /Change /TN "Microsoft\Windows\Shell\FamilySafetyMonitor" /Enable
echo "FSM Enabled (Restart needed)"
goto :promptrestart
:disable
schtasks /Change /TN "Microsoft\Windows\Shell\FamilySafetyMonitor" /Disable
echo "FSM Disabled (Restart needed)"
goto :promptrestart
:notadmin
echo "Not running as admin"
:restart
shutdown /r /t 0
:end
pause
exit
:promptrestart
echo "Do you want to restart now?"
set /p choice=Type Y or N then press ENTER:
if %choice% == Y goto :restart
if %choice% == N goto :end
