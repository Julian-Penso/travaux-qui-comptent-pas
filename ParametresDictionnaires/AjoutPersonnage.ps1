param(
    [string]$Nom,
    [string]$Prenom,
    [string]$Ordre
)
[PSCustomObject]@{
    Nom = $Nom
    Prenom = $Prenom
    Ordre = $Ordre
}
