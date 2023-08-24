#Requires -RunAsAdministrator
$features = @("Microsoft-Hyper-V-All", "Microsoft-Windows-Subsystem-Linux", "VirtualMachinePlatform", "Containers-DisposableClientVM")
foreach ($feature in $features) {
  echo "  * installing $feature"
  $state = Get-WindowsOptionalFeature -Online -FeatureName $feature
  if ($state.State -ne "Enabled") {
    Enable-WindowsOptionalFeature -Online -FeatureName $feature -NoRestart
  }
}
