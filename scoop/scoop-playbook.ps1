#Requires -Version 5.1
using namespace System.Collections.Generic

[CmdletBinding()]
param (
    [ValidateSet("run", "check", "update_scoop")]
    [string]$Mode = "run"
)

Set-StrictMode -Version Latest

enum Keywords {name; scoop_install; scoop_uninstall; }
enum RunMode {check; run; update_scoop; }

# setup
$check = ""
if ($Mode -eq [RunMode]::check) {
    Write-Host -ForeGroundColor Yellow "Run with $Mode mode"
    $check = [RunMode]::check.ToString()
}

function Prerequisites {
    [OutputType([bool])]
    param ()

    # scoop status
    $pathExists = ($env:PATH -split ";") | where {$_ -match "scoop"} | Measure-Object
    if ($pathExists.Count -gt 0) {
        return $true
    }
    else {
        Write-Error "scoop not exists in PATH!!"
        return $false
    }
    
    # status
    scoop status
    if (!$?) {
        return $false
    }

    # check potential problem
    scoop checkup
}

function RunMain {
    [OutputType([int])]
    param(
        [string]$BaseYaml = "site.yml"
    )
    
    $definitions = Get-Content -LiteralPath $BaseYaml -Raw | ConvertFrom-Yaml
    # BaseYaml's role existstance check
    foreach ($item in ($definitions.Values.ToArray())) {
        $tasks = Get-ChildItem -LiteralPath "roles/$item/tasks/" -Include *.yml -File
        if ($null -eq $tasks) {
            continue
        }

        # role's Task check and run
        foreach ($task in $tasks.FullName) {
            Write-Host -ForeGroundColor Green "Role [$item] from [$task]"
            $taskDef = Get-Content -LiteralPath $task -Raw | ConvertFrom-Yaml
            # role
            foreach ($def in $taskDef) {
                # task contains "scoop_install" check
                $containsInstall = $def.Contains([Keywords]::scoop_install.ToString())
                # task contains "scoop_uninstall" check
                $containsUninstall = $def.Contains([Keywords]::scoop_uninstall.ToString())
                if ($containsInstall) {
                    Write-Host -ForeGroundColor Cyan "running [$($def.name)]"
                    ScoopInstall -TaskDef $def -Tag $item
                }
                elseif ($containsUninstall) {
                    Write-Host -ForeGroundColor Cyan "running [$($def.name)]"
                    ScoopUninstall -TaskDef $def -Tag $item
                }
                else {
                    Write-Host -ForeGroundColor Cyan "skipped [$($def.name)]"
                    continue
                }   
            }
        }
    }
}

function ScoopInstall {
    [OutputType([int])]
    param(
        [HashTable]$TaskDef,
        [string]$Tag
    )

    $tools = $TaskDef.scoop_install
    if ($null -eq $tools) {
        return
    }

    foreach ($tool in $tools) {
        # blank definition
        if ([string]::IsNullOrWhiteSpace($tool)) {
            continue
        }

        if ($check -eq [RunMode]::check) {
            Write-Host "[$check]$Tag [$([Keywords]::scoop_install): $tool] ==========================="
            $output = scoop info $tool
            $installedLine = $output -match "Installed"
            if ($installedLine -match "No") {
                Write-Host -ForeGroundColor Yellow "$installedLine"
            }
            elseif ($installedLine -match "Yes") {
                Write-Host -ForeGroundColor DarkGray "$installedLine"
            }
            else {
                return 1
            }
        }
        else {
            $output = scoop info $tool
            $installedLine = $output -match "Installed"
            if ($installedLine -match "No") {
                Write-Host "$Tag [$([Keywords]::scoop_install): $tool] ==========================="
                scoop install $tool
            }
            else {
                Write-Host -ForeGroundColor DarkGray "$Tag [$([Keywords]::scoop_install): $tool] already installed, updating ==========================="
                scoop update $tool
            }
        }
    }
}

function ScoopUninstall {
    [OutputType([int])]
    param(
        [HashTable]$TaskDef,
        [string]$Tag
    )

    $tools = $TaskDef.scoop_uninstall
    if ($null -eq $tools) {
        return
    }

    foreach ($tool in $tools) {
        # blank definition
        if ([string]::IsNullOrWhiteSpace($tool)) {
            continue
        }

        if ($check -eq [RunMode]::check) {
            Write-Host "[$check]$Tag [$([Keywords]::scoop_uninstall): $tool] ==========================="
            $output = scoop info $tool
            $installedLine = $output -match "Installed"
            if ($installedLine -match "Yes") {
                Write-Host -ForeGroundColor Yellow "$installedLine"
            }
            elseif ($installedLine -match "No") {
                Write-Host -ForeGroundColor DarkGray "$installedLine"
            }
            else {
                return 1
            }
        }
        else {
            Write-Host "$Tag [$([Keywords]::scoop_uninstall): $tool] ==========================="
            scoop uninstall $tool
        }
    }
}

# prerequisites
if ($Mode -eq [RunMode]::update_scoop.ToString()) {
    scoop update
}
else {
    $ok = Prerequisites
    if (!$?) { return 1 }
    if (!$ok) { return 1 }
    
    # run
    RunMain    
}
