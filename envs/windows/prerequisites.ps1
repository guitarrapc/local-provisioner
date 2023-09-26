$progressPreference = 'silentlyContinue'

function PrintInfo($message) {
  Write-Host $message -ForegroundColor Cyan
}
function PrintError($message) {
  Write-Host $message -ForegroundColor Red
}

PrintInfo -message "Installing scoop."
if ($null -eq (Get-Command scoop.ps1*)) {
  iex (new-object net.webclient).downloadstring('https://get.scoop.sh')
}

PrintInfo -message "Updating scoop to latest"
scoop update

foreach ($item in @("7zip", "innounp", "dark", "sudo")) {
  PrintInfo -message "Install/Update scoop package $item"
  scoop install $item
  scoop update $item
  if (!$?) {
    PrintError -message "Could not complete installation $item. Please try again."
    scoop uninsatll $item
    return
  }
}

PrintInfo -message "Checking scoop status"
scoop checkup

PrintInfo -message "Installing required modules"
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Scope CurrentUser -Force
$modules = Get-Module -ListAvailable
Install-Module "PowerShell-Yaml" -Scope CurrentUser -Force -AllowClobber
Install-Module "ScoopPlaybook" -Scope CurrentUser -Force -AllowClobber

PrintInfo -message "You are ready to run ScoopPlaybook!!"
