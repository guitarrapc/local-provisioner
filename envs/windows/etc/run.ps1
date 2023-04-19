./add-gitpath.ps1
./add-nugetorg.ps1
sudo ./add-windowsdefender-exclude-visualstudio.ps1
sudo ./install-windowsfeature.ps1
sudo ./Set-ConnectionProfile.ps1
. .\enable_longpath.reg
. "${env:UserProfile}/scoop/apps/vscode/current/install-context.reg"
./Set-GoModuleEnv.ps1
