@echo off
if "%~1"=="" (
    powershell.exe -NoExit -Command "&{Import-Module """C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\Tools\Microsoft.VisualStudio.DevShell.dll"""; Enter-VsDevShell f0d52895 -SkipAutomaticLocation -DevCmdArguments """-arch=x64 -host_arch=x64"""}"
) else (
    powershell.exe -NoExit -Command "&{Import-Module """C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\Tools\Microsoft.VisualStudio.DevShell.dll"""; Enter-VsDevShell f0d52895 -SkipAutomaticLocation -DevCmdArguments """-arch=x64 -host_arch=x64"""; %*}"
)
