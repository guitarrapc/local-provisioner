#requires -RunAsAdministrator
$ErrorActionPreference = 'Stop'

# remove current entry
foreach ($item in $(netsh interface portproxy show v4tov4 | grep "127.0.0.1")) {
  $line = $($item -replace " {2,}", " ")
  $listenaddress = $line.Split(" ")[2]
  $port = $line.Split(" ")[3]
  Write-Output "Removing ${listenaddress}:${port}"
  netsh interface portproxy delete v4tov4 listenport=$port listenaddress=$listenaddress
}

# launch wsl2
wsl.exe -d Ubuntu-22.04 --exec cat /etc/resolv.conf

$adapters = $("vEthernet (WSL)", "vEthernet (WSL (Hyper-V firewall))")
foreach ($adapter in $adapters) {

  # disable Windows Firewall for WSL2 Interface
  Set-NetFirewallProfile -DisabledInterfaceAliases "$adapter" -Name Private

  # Allow WSL2 to access Windows Docker Daemon to share same images.
  $wslAddress = (Get-NetIPAddress -InterfaceAlias "$adapter" -AddressFamily IPv4).IPAddress
  iex "netsh interface portproxy add v4tov4 listenport=2375 connectaddress=127.0.0.1 connectport=2375 listenaddress=$wslAddress protocol=tcp"

  # Allow WSL2 to access Windows Kubernetes Cluster
  iex "netsh interface portproxy add v4tov4 listenport=6443 connectaddress=127.0.0.1 connectport=6443 listenaddress=$wslAddress protocol=tcp"
}

# check result
netsh interface portproxy show v4tov4

Start-Sleep -Seconds 3
