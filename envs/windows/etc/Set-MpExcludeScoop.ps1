#Requires -RunAsAdministrator
foreach ($item in @("$env:UserProfile\scoop", "$env:ProgramData\scoop")) {
  Add-MpPreference -ExclusionPath $item
}
