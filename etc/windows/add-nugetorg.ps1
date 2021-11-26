# if using Install-Module before first launch of Visual Studio, nuget.org package source will be missing.
# ref: https://github.com/NuGet/Home/issues/10804
dotnet nuget add source https://api.nuget.org/v3/index.json -n nuget.org
