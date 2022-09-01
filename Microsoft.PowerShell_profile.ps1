# Startup commands

# Removing bell
Set-PSReadlineOption -BellStyle None

# Run Screenfetch (should be ultra fast)
winfetch

# Environment Variables
$C = 'C:\localdev'
$D = 'D:\localdev'
$G = 'G:\localdev'
$DBOX = 'D:\Dropbox'
$WORK = 'D:\localdev\fetchly'
$POSH = 'D:\Users\Mestre\Documents\WindowsPowerShell\'

Write-Host "`n"
Write-Host 'Current environment variables set: $C, $D, $G, $DBOX, $POSH, $WORK'
Write-Host 'Powershell settings at $PROFILE'
Write-Host 'To restart starship, use starship_boot'

# Utility for admin/sudo check
function Test-Administrator  
{  
    $user = [Security.Principal.WindowsIdentity]::GetCurrent();
    (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)  
}

if (Test-Administrator) {
  Write-Host 'This prompt has elevated privileges'
} 
else {
  Write-Host 'Warning: This prompt does NOT have elevated privileges' 
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

# Starship startup utilities
function Start-Starship
{
  Invoke-Expression (&starship init powershell)
}

Set-Alias -Name starship_boot -Value Start-Starship
starship_boot




