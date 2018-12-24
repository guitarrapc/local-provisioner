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
$lineWidth = 83

function Prerequisites {
    [OutputType([bool])]
    param ()

    # scoop status
    $pathExists = ($env:PATH -split ";") | Where-Object {$_ -match "scoop"} | Measure-Object
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
    $playbookName = $definitions["name"]
    $roles = $definitions["roles"].ToArray()

    # BaseYaml's role existstance check
    $marker = "*" * ($lineWidth - "PLAY [$playbookName]".Length)
    Write-Host "PLAY [$playbookName] $marker"
    Write-Output ""
    foreach ($item in $roles) {
        $tasks = Get-ChildItem -LiteralPath "roles/$item/tasks/" -Include *.yml -File
        if ($null -eq $tasks) {
            continue
        }

        # role's Task check and run
        foreach ($task in $tasks.FullName) {
            Write-Verbose "Read from [$task]"
            $taskDef = Get-Content -LiteralPath $task -Raw | ConvertFrom-Yaml

            # role
            foreach ($def in $taskDef) {
                $name = $def.name
                # task contains "scoop_install" check
                $containsInstall = $def.Contains([Keywords]::scoop_install.ToString())
                # task contains "scoop_uninstall" check
                $containsUninstall = $def.Contains([Keywords]::scoop_uninstall.ToString())
                if ($containsInstall) {
                    $marker = "*" * ($lineWidth - "TASK [$item : $name]".Length)
                    Write-Host "TASK [$item : $($name)] $marker"
                    ScoopInstall -TaskDef $def
                }
                elseif ($containsUninstall) {
                    $marker = "*" * ($lineWidth - "TASK [$item : $name]".Length)
                    Write-Host "TASK [$item : $($name)] $marker"
                    ScoopUninstall -TaskDef $def
                }
                else {
                    $marker = "*" * ($lineWidth - "skipped: TASK [$item : $name]".Length)
                    Write-Host DarkCyan "skipped: TASK [$item : $($name)] $marker"
                    continue
                }
                Write-Output ""
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
            Write-Host "check: [$([Keywords]::scoop_install): $tool]"
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
                Write-Host "changed: [$([Keywords]::scoop_install): $tool]"
                scoop install $tool
            }
            else {
                Write-Host -ForeGroundColor Green "ok: [$([Keywords]::scoop_install): $tool]"
                scoop update $tool
            }
        }
    }
}

function ScoopUninstall {
    [OutputType([int])]
    param(
        [HashTable]$TaskDef
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
            Write-Host "check: [$([Keywords]::scoop_uninstall): $tool]"
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
            Write-Host -ForegroundColor Yellow "changed: [$([Keywords]::scoop_uninstall): $tool]"
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
