param(
    [string[]]$Name
)
foreach ($Utilisateur in $Name) {
    Get-LocalUser -Name "$Utilisateur" -ErrorAction SilentlyContinue
}
