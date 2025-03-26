#Requires -RunAsAdministrator
function ReloadEnvironmentVariables {
  echo "Reload environment variables"
  $machinePath = [Environment]::GetEnvironmentVariable("PATH", "machine")
  $userPath = [Environment]::GetEnvironmentVariable("PATH", "user")
  $newPath = "$userPath;$machinePath"
  [Environment]::SetEnvironmentVariable("PATH", "$newPath", "process")
}

echo "Set Windows"
. ./enable_longpath.reg
./install-windowsfeature.ps1
./Set-ConnectionProfile.ps1
./disable-faststartup.ps1

echo "Install winget tools"
./install-winget.ps1
./install-vstools.ps1
ReloadEnvironmentVariables

echo "dotnet fix"
./add-nugetorg.ps1

echo "go fix"
./Set-GoModuleEnv.ps1

echo "Set Windows Defender"
./add-windowsdefender-exclude-visualstudio.ps1
./Set-MpExcludeScoop.ps1
