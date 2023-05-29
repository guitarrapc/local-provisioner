#Requires -RunAsAdministrator
foreach ($item in @("$env:UserProfile\scoop", "$env:ProgramData\scoop")) {
  sudo Add-MpPreference -ExclusionPath $item
}
