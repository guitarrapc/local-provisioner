#Requires -RunAsAdministrator
$features = @("Microsoft-Hyper-V-All", "Microsoft-Windows-Subsystem-Linux", "VirtualMachinePlatform")
foreach ($feature in $features) {
  $state = Get-WindowsOptionalFeature -Online -FeatureName $feature
  if ($state.State -ne "Enabled") {
    Enable-WindowsOptionalFeature -Online -FeatureName $feature
  }
}
