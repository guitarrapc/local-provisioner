$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if (!$currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    $myfunction = $MyInvocation.InvocationName
    $cd = (Get-Location).Path
    $commands = "Set-Location $cd; $myfunction; Pause"
    $bytes = [System.Text.Encoding]::Unicode.GetBytes($commands)
    $encode = [Convert]::ToBase64String($bytes)
    $argumentList = "-NoProfile", "-ExecutionPolicy RemoteSigned", "-EncodedCommand", $encode

    Write-Warning "Detected you are not runnning with Admin Priviledge."
    $proceed = Read-Host "Required elevated priviledge to install windows features. Do you proceed? (y/n)"
    if ($proceed -ceq "y") {
        $p = Start-Process -Verb RunAs powershell.exe -ArgumentList $argumentList -Wait -PassThru
        exit $p.ExitCode
    }
    else {
        Write-Host "Cancel evelated."
        exit 1
    }
}

# WSL for ubuntu
sudo Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
# Hyper-V for Docker
sudo Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All