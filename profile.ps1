# terminalSkin - PowerShell prompt
# Same look as the bashrc prompt:
#   +-[x]-[user@host]-[branch]-[~\dir]
#   +-[PS]-> $   (drawn with box characters)
#
# Install: copy this file to $PROFILE.
# The file is pure ASCII on purpose (box characters are built from char codes),
# so it works in Windows PowerShell 5.1 and PowerShell 7 regardless of encoding.

$script:HasGit = [bool](Get-Command git -ErrorAction SilentlyContinue)

function prompt {
    $ok = $?
    $savedExitCode = $global:LASTEXITCODE

    $e  = [char]27
    $tl = [char]0x250C
    $bl = [char]0x2514
    $h  = [char]0x2500
    $tr = [char]0x257C
    $x  = [char]0x2717

    $red    = "$e[0;31m"
    $green  = "$e[0;32m"
    $yellow = "$e[01;33m"
    $cyan   = "$e[01;96m"
    $grey   = "$e[0;37m"
    $reset  = "$e[0m"

    $isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(
        [Security.Principal.WindowsBuiltInRole]::Administrator)
    $userColor = if ($isAdmin) { "$e[01;31m" } else { "$e[0;39m" }

    # Path, with home shortened to ~
    $path = $ExecutionContext.SessionState.Path.CurrentLocation.ProviderPath
    if ($path -and $path.StartsWith($HOME, [StringComparison]::OrdinalIgnoreCase)) {
        $path = '~' + $path.Substring($HOME.Length)
    }

    # Git branch (commit hash on detached HEAD)
    $branch = $null
    if ($script:HasGit) {
        $branch = git symbolic-ref --short HEAD 2>$null
        if (-not $branch) { $branch = git rev-parse --short HEAD 2>$null }
    }

    $s = "$red$tl$h"
    if (-not $ok) { $s += "[$red$x$grey]$red$h" }
    $s += "[$userColor$env:USERNAME$yellow@$cyan$env:COMPUTERNAME$red]$h"
    if ($branch) { $s += "[$e[36m$branch$red]$h" }
    $s += "[$green$path$red]`n"
    $s += "$red$bl$h[$cyan" + "PS$red]$h$tr $yellow" + $(if ($isAdmin) { '#' } else { '$' }) + "$reset "

    # Window title: user@host: dir
    $Host.UI.RawUI.WindowTitle = "$env:USERNAME@$env:COMPUTERNAME`: $path"

    $global:LASTEXITCODE = $savedExitCode
    $s
}
