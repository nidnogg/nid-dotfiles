# Startup commands

# Removing bell
Set-PSReadlineOption -BellStyle None

# Run Screenfetch (ultra fast!)
winscreenfetch

# Environment Variables
$D = 'D:\localdev'
$G = 'G:\localdev'
$DBOX = 'D:\Dropbox'
$POSH = 'D:\Users\Mestre\Documents\WindowsPowerShell\'
$GSUTILS = 'C:\Users\henri\AppData\Local\Google\Cloud SDK\cloudtop-cors'

Write-Host "`n"
Write-Host 'Current environment variables set: $D, $G, $DBOX, $POSH, $GSUTILS'
Write-Host 'Powershell settings at $POSH'
Write-Host 'Conda settings at $POSH /profile.ps1'
Write-Host '$GOPATH set to $D/go'
Write-Host 'gsutils cors config info at $GSUTILS'
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

# Aliases for missing nix commands
# ripgrep as grep
Set-Alias -Name grep -Value rg
# ni as touch
Set-Alias -Name touch -Value ni

# Starship startup utilities
function Start-Starship
{
  Invoke-Expression (&starship init powershell)
}

Set-Alias -Name starship_boot -Value Start-Starship
starship_boot

# oh-my-posh theming utilities
# oh-my-posh init pwsh --config "$(scoop prefix oh-my-posh)\themes\gruvbox.omp.json" | Invoke-Expression


  