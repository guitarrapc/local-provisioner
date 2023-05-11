#Requires -RunAsAdministrator
#Requires -Version 5
Get-ScheduledTask | where TaskName -eq "Microsoft Compatibility Appraiser" | Disable-ScheduledTask

# TaskPath                                       TaskName                          State
# --------                                       --------                          -----
# \Microsoft\Windows\Application Experience\     Microsoft Compatibility Appraiser Disabled
