#Requires -RunAsAdministrator

# path excludes
$pathes = @(
  "$env:ProgramData\Microsoft\VisualStudio\Packages",
  "$env:ProgramFiles\dotnet",
  "$env:ProgramFiles\Microsoft SDKs",
  "$env:ProgramFiles\MSBuild",
  "$env:ProgramFiles\Unity",
  "$env:ProgramFiles\Unity Hub",
  "${env:ProgramFiles(x86)}\Microsoft SDKs",
  "${env:ProgramFiles(x86)}\Microsoft SDKs\NuGetPackages",
  "${env:ProgramFiles(x86)}\Microsoft Visual Studio",
  "${env:ProgramFiles(x86)}\MSBuild",
  "$env:SystemRoot\assembly",
  "$env:SystemRoot\Microsoft.NET",
  "$env:AppData\Microsoft\VisualStudio",
  "$env:LocalAppData\Microsoft\VisualStudio"
)
foreach ($item in $pathes) {
  Add-MpPreference -ExclusionPath $item
}

# process exclues
$processes = @(
  "devenv.exe", # Visual Studio
  "dotnet.exe",
  "msbuild.exe",
  "perfwatson2", # Visual Studio feedback
  "ServiceHub.RoslynCodeAnalysisService.exe", # Roslyn Analyzer
  "vbcscompiler"
)
foreach ($item in $processes) {
  Add-MpPreference -ExclusionProcess $item
}
