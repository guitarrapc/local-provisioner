#Requires -RunAsAdministrator
function ReloadEnvironmentVariables {
  echo "Reload environment variables"
  $machinePath = [Environment]::GetEnvironmentVariable("PATH", "machine")
  $userPath = [Environment]::GetEnvironmentVariable("PATH", "user")
  $newPath = "$userPath;$machinePath"
  [Environment]::SetEnvironmentVariable("PATH", "$newPath", "process")
}

echo "Follow up scoop app"
. "${env:UserProfile}/scoop/apps/vscode/current/install-context.reg"

echo "Install winget tools"
./install-winget.ps1
./install-vstools.ps1
ReloadEnvironmentVariables

echo "dotnet fix"
./add-nugetorg.ps1

echo "Set Windows"
. ./enable_longpath.reg
./Set-GoModuleEnv.ps1
./Set-ConnectionProfile.ps1
./disable-faststartup.ps1

echo "Set Windows Defender"
./add-windowsdefender-exclude-visualstudio.ps1
./Set-MpExcludeScoop.ps1

echo "Install Windows features"
./install-windowsfeature.ps1
