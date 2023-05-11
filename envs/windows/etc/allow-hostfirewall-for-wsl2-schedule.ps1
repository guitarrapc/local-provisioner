#Requires -RunAsAdministrator

$ErrorActionPreference = 'Stop'

Get-ScheduledTask | where TaskName -eq "AllowHostFirewallForWsl2" | UnRegister-ScheduledTask -Confirm:$false

$dir=[System.IO.Directory]::GetParent($MyInvocation.MyCommand.Path).FullName
$script="$dir\allow-hostfirewall-for-wsl2.ps1"
$actions = (New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-command $script")
$trigger = New-ScheduledTaskTrigger -AtLogon -User $env:UserName
$trigger.Delay = "PT5M" # delay 5min
$principal = New-ScheduledTaskPrincipal -UserId $env:UserName -RunLevel Highest
$settings = New-ScheduledTaskSettingsSet -RunOnlyIfNetworkAvailable -WakeToRun -Hidden
$task = New-ScheduledTask -Action $actions -Principal $principal -Trigger $trigger -Settings $settings
Register-ScheduledTask 'AllowHostFirewallForWsl2' -InputObject $task
