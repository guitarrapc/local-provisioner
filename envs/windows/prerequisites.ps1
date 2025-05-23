$progressPreference = 'silentlyContinue'

function PrintInfo($message) {
  Write-Host $message -ForegroundColor Cyan
}
function PrintError($message) {
  Write-Host $message -ForegroundColor Red
}

PrintInfo -message "# Installing scoop..."
if ($null -eq (Get-Command scoop.ps1*)) {
  iex (new-object net.webclient).downloadstring('https://get.scoop.sh')
}

PrintInfo -message "# Updating scoop to latest..."
scoop update

PrintInfo -message "# Checking fundamental packages are installed..."
foreach ($item in @("7zip")) {
  PrintInfo -message "* Install/Update scoop package $item"
  scoop install $item
  scoop update $item
  if (!$?) {
    PrintError -message "Could not complete installation $item. Please try again."
    scoop uninstall $item
    exit 1
  }
}

PrintInfo -message "# Checking sudo is installed..."
if ($null -eq (Get-Command sudo.exe)) {
  $sudoAvailable = [Version]"10.0.26100" # Windows 11 24H2
  $windowsVersion = [System.Environment]::OSVersion.Version

  if ($windowsVersion.Major -ge $sudoAvailable.Major -and $windowsVersion.Minor -ge $sudoAvailable.Minor -and $windowsVersion.Build -ge $sudoAvailable.Build) {
    PrintError -message "Your Windows version is higher than Windows 11 24H2, please install sudo (inline) from Developer settings."
    exit 1
  } else {
    scoop install sudo
    scoop update $item
    if (!$?) {
      PrintError -message "Could not complete installation $item. Please try again."
      scoop uninstall $item
      exit 1
    }
  }
}

PrintInfo -message "# Checking scoop status..."
scoop checkup

PrintInfo -message "# Installing required modules..."
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Scope CurrentUser -Force
$modules = Get-Module -ListAvailable
Install-Module "PowerShell-Yaml" -Scope CurrentUser -Force -AllowClobber
Install-Module "ScoopPlaybook" -Scope CurrentUser -Force -AllowClobber

PrintInfo -message "You are ready to run ScoopPlaybook..."
