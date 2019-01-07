Set-ExecutionPolicy RemoteSigned -scope CurrentUser
iex (new-object net.webclient).downloadstring('https://get.scoop.sh')

# git to update scoop
scoop install git

# update scoop
scoop update

# yaml required
Install-Module PowerShell-Yaml -Scope CurrentUser
# Module
Install-Module ScoopPlaybook -Scope CurrentUser