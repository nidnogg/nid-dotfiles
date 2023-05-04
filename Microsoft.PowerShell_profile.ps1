# Startup commands

# Removing bell
Set-PSReadlineOption -BellStyle None

# Run zeitfetch
zeitfetch

# Environment Variables
$C = 'C:\localdev'
$D = 'D:\localdev'
$G = 'G:\localdev'
$DBOX = 'D:\Dropbox'
$WORK = 'D:\localdev\fetchly'
$JOBSP = 'D:\localdev\fetchly\jobspeaker\api_hunt\jobspeaker-services\services\jobspeaker-node-api'
$POSH = 'D:\Users\Mestre\Documents\WindowsPowerShell\'

Write-Host "`n"
Write-Host 'Current environment variables set: $C, $D, $G, $DBOX, $POSH, $WORK, $JOBSP,'
Write-Host 'Powershell settings at $PROFILE'
Write-Host "To launch unsafe chrome, use 'cherome'"
Write-Host "To restart starship, use 'starship_boot'"

# Utility for admin/sudo check
function Test-Administrator
{
    $user = [Security.Principal.WindowsIdentity]::GetCurrent()
    (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

function Unsafe-Chrome
{
  # chrome.exe $args --allow-file-access-from-files --disable-web-security --user-data-dir='C:\Users\henri\AppData\Local\Google\Chrome\User Data';
  chrome.exe $args --allow-file-access-from-files --disable-web-security --user-data-dir='D:\localdev\unsafe_chrome_data';
}

if (Test-Administrator) {
  Write-Host 'This prompt has elevated privileges'
}
else {
  Write-Host 'Warning: This prompt does NOT have elevated privileges'
}

function Bat-Alias
{
    param(
        [string[]]$Path
    )

    & bat $Path -P
}


# Syntax highlighting
Import-Module PSReadLine

# Default font used to be DejaVu Sans Mono, size 12pt

# Aliases for improved/missing nix commands
# ripgrep as grep
Set-Alias -Name grep -Value rg
# ni as touch
Set-Alias -Name touch -Value ni
# lsd as ls
Set-Alias -Name ls -Value lsd
# bat as cat
Set-Alias -Name cat -Value Bat-Alias

# Misc aliases
# unsafe chrome
Set-Alias -Name cherome -Value Unsafe-Chrome

# Starship startup utilities
function Start-Starship
{
  Invoke-Expression (&starship init powershell)
}

# Ln for hard links
function Add-Hard-Link ($target, $link) {
  New-Item -Path $link -ItemType HardLink -Value $target
}

# ln for symbolic links
function Add-Symbolic-Link ($target, $link) {
  New-Item -Path $link -ItemType SymbolicLink -Value $target
}

Set-Alias -Name starship_boot -Value Start-Starship
starship_boot




