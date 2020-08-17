function PrintInfo($message) {
  Write-Host $message -ForegroundColor Cyan
}
function PrintError($message) {
  Write-Host $message -ForegroundColor Red
}

PrintInfo -message "checking execution policy for current user."
if ((Get-ExecutionPolicy -Scope CurrentUser) -ne "RemoteSigned") {
  Set-ExecutionPolicy RemoteSigned -scope CurrentUser
}
PrintInfo -message "checking scoop is installed."
if ($null -eq (Get-Command scoop.ps1*)) {
  iex (new-object net.webclient).downloadstring('https://get.scoop.sh')
}

PrintInfo -message "install/update required scoop package"
foreach ($item in @("7zip", "dark", "git", "innounp", "sudo")) {
  scoop install $item
  scoop update $item
  if (!$?) {
    PrintError -message "Could not complete installation $item. Please run 'scoop uninstall $item' then run again."
    return
  }
}

PrintInfo -message "update and check scoop"
scoop update
scoop checkup

PrintInfo -message "exclude scoop path from Microsoft Defender"
foreach ($item in @("$env:UserProfile\scoop", "$env:ProgramData\scoop")) {
  sudo Add-MpPreference -ExclusionPath $item
}

PrintInfo -message "enable longpath support"
if (1 -ne (Get-ItemPropertyValue 'HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem' -Name 'LongPathsEnabled')) {
  sudo Set-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem' -Name 'LongPathsEnabled' -Value 1
}

PrintInfo -message "install required modules"
$modules = Get-Module -ListAvailable
foreach ($item in @("PowerShell-Yaml", "ScoopPlaybook")) {
  if ($null -eq ($modules | where name -eq $item)) {
    Install-Module $item -Scope CurrentUser -Force -AllowClobber
  }
}

PrintInfo -message "Please install non-scoop apps, Docker for Windows, and enable WSL2."
