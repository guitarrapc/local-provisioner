$gitCmdPath = "${env:USERPROFILE}\scoop\apps\git\current\cmd"
$userPath = [Environment]::GetEnvironmentVariable("PATH", [EnvironmentVariableTarget]::User)
# git path exists?
if (-not (Test-Path "${env:USERPROFILE}\scoop\shims\git.exe")) {
  Write-Output "git not found in scoop PATH. Please run ``scoop install git`` first."
} else {
  # add scoop git raw path to 1st PATH index.
  if ($userPath.Split(";") -notcontains "$gitCmdPath") {
    $newUserPath = $gitCmdPath + ";" + $userPath
    Write-Warning "git cmd not found in your PATH, let's replace to new PATH"
    Write-Warning "PATH (before). $userPath"
    Write-Warning "PATH (after).  $newUserPath"
    [Environment]::SetEnvironmentVariable("PATH", $newUserPath, [EnvironmentVariableTarget]::User)
    Write-Output "Complete. Updated to New PATH. $([Environment]::GetEnvironmentVariable("PATH", [EnvironmentVariableTarget]::User))"
  } else {
    Write-Output "git cmd is already in your PATH. $userPath"
  }
}
