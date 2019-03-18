Set-ExecutionPolicy RemoteSigned -scope CurrentUser
if ($nul -eq (Get-Command scoop)) {
    iex (new-object net.webclient).downloadstring('https://get.scoop.sh')
}

# git to update scoop
scoop install git

# update scoop
scoop update

# check scoop status
scoop checkup

# exclude scoop
scoop install sudo
sudo Add-MpPreference -ExclusionPath "$env:UserProfile\scoop"
sudo Add-MpPreference -ExclusionPath 'C:\ProgramData\scoop'

# yaml required
Install-Module PowerShell-Yaml -Scope CurrentUser -Force
# Module
Install-Module ScoopPlaybook -Scope CurrentUser -Force