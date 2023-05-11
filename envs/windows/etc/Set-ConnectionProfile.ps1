#Requires -RunAsAdministrator
Get-NetConnectionProfile | Set-NetConnectionProfile -NetworkCategory Private
