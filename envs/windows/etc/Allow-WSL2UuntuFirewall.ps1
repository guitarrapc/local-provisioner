# launch wsl2
wsl.exe -d Ubuntu-22.04 --exec cat /etc/resolv.conf
# disable Windows Firewall for WSL2 Interface
Set-NetFirewallProfile -DisabledInterfaceAliases "vEthernet (WSL)" -Name Public

# Allow WSL2 to access Windows Docker Daemon to share same images.
$wslAddress = (Get-NetIPAddress -InterfaceAlias "vEthernet (WSL)" -AddressFamily IPv4).IPAddress
iex "netsh interface portproxy add v4tov4 listenport=2375 connectaddress=127.0.0.1 connectport=2375 listenaddress=$wslAddress protocol=tcp"

# check result
netsh interface portproxy show v4tov4
