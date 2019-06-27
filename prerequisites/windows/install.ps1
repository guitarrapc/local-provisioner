function PrintInfo($message) {
    Write-Host $message -ForegroundColor Cyan
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
foreach ($item in @("git", "innounp", "dark", "sudo", "dark")) {
    scoop install $item
    scoop update $item
}

PrintInfo -message "update and check scoop"
scoop update
scoop checkup

PrintInfo -message "exclude scoop path from Microsoft Defender"
foreach ($item in @("$env:UserProfile\scoop", "$env:ProgramData\scoop")) {
    if (!((Get-MpPreference).ExclusionPath -contains $item)) {
        sudo Add-MpPreference -ExclusionPath $item
    }
}

PrintInfo -message "set longpath support"
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
