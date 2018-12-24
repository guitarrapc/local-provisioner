Set-ExecutionPolicy RemoteSigned -scope CurrentUser
iex (new-object net.webclient).downloadstring('https://get.scoop.sh')

# update scoop
scoop update
scoop bucket add extras

# yaml required
Install-Module PowerShell-Yaml -Scope CurrentUser