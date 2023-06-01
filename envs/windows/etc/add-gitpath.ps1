# # Workaround for Unity Package Manager git error, which happen when uysing `git` installed via scoop.
# This script enable scoop installed git to run directly without symbolic link.
# detail: https://github.com/ScoopInstaller/Scoop/issues/4317

$gitCmdPath = "${env:USERPROFILE}\scoop\apps\git\current\cmd"
$userPath = [Environment]::GetEnvironmentVariable("PATH", [EnvironmentVariableTarget]::User)
# git path exists?
if (-not (Test-Path "${env:USERPROFILE}\scoop\shims\git.exe")) {
  Write-Output "Nothing to do. git not found in scoop PATH. You are not using scoop' git."
} else {
  # add scoop git raw path to 1st PATH index.
  if ($userPath.Split(";") -notcontains "$gitCmdPath") {
    $newUserPath = $gitCmdPath + ";" + $userPath
    Write-Warning "Begin change. git cmd not found in your PATH, let's replace to new PATH"
    Write-Warning "  * PATH (before). $userPath"
    Write-Warning "  * PATH (after).  $newUserPath"
    [Environment]::SetEnvironmentVariable("PATH", $newUserPath, [EnvironmentVariableTarget]::User)
    Write-Output "Completed. Updated to New PATH. $([Environment]::GetEnvironmentVariable("PATH", [EnvironmentVariableTarget]::User))"
  } else {
    Write-Output "Nothing happen. git cmd is already in your PATH. $userPath"
  }
}
