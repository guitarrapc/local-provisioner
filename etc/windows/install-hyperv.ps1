#Requires -RunAsAdministrator
$state = Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All
if ($state.State -ne "Enabled") {
    Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All
}