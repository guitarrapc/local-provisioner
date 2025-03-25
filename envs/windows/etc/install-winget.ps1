# Core tools
winget install -e --id Docker.DockerDesktop --accept-package-agreements
winget install -e --id Logitech.OptionsPlus --accept-package-agreements
winget install -e --id Microsoft.VisualStudio.2022.Professional --accept-package-agreements
winget install -e --id Unity.UnityHub --accept-package-agreements
winget install -e --id Git.Git --accept-package-agreements
winget install -e --id GitHub.GitLFS --accept-package-agreements
winget install -e --id Google.Chrome --accept-package-agreements
winget install -e --id Microsoft.VisualStudioCode --override '/SILENT /mergetasks="!runcode,addcontextmenufiles,addcontextmenufolders"'

