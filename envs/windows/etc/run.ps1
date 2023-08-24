echo "Follow up scoop app"
. "${env:UserProfile}/scoop/apps/vscode/current/install-context.reg"

echo "Install winget tools"
sudo ./install-winget.ps1
sudo ./install-vstools.ps1

echo "Reload environment variables"
$machinePath = [Environment]::GetEnvironmentVariable("PATH", "machine")
$userPath = [Environment]::GetEnvironmentVariable("PATH", "user")
$newPath = "$userPath;$machinePath"
[Environment]::SetEnvironmentVariable("PATH", "$newPath", "process")

echo "dotnet fix"
./add-nugetorg.ps1

echo "Set Windows"
. ./enable_longpath.reg
./Set-GoModuleEnv.ps1
sudo ./Set-ConnectionProfile.ps1

echo "Set Windows Defender"
sudo ./add-windowsdefender-exclude-visualstudio.ps1
sudo ./Set-MpExcludeScoop.ps1

echo "Install Windows features"
sudo ./install-windowsfeature.ps1
