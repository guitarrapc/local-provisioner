# Core tools
winget install -e --id Docker.DockerDesktop --accept-package-agreements
winget install -e --id Logitech.OptionsPlus --accept-package-agreements
winget install -e --id Microsoft.VisualStudio.2022.Professional --accept-package-agreements
winget install -e --id Unity.UnityHub --accept-package-agreements
winget install -e --id Git.Git --accept-package-agreements
winget install -e --id GitHub.GitLFS --accept-package-agreements
winget install -e --id Google.Chrome --accept-package-agreements
winget install -e --id Microsoft.VisualStudioCode --override '/SILENT /mergetasks="!runcode,addcontextmenufiles,addcontextmenufolders"'
winget install -e --id Microsoft.PowerShell --accept-package-agreements
winget install -e --id Anysphere.Cursor --accept-package-agreements
# chatgpt (codex)
winget install -e --id 9PLM9XGG6VKS -s msstore --accept-package-agreements
winget install -e --id Anthropic.Claude --accept-package-agreements
winget install -e --id GitHub.CopilotApp --accept-package-agreements
