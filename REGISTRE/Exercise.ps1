<# 
===========================================================
420-3T5-EM Automatisation de tâches
Exercices — Registre Windows
===========================================================

PARTIE 1 — EXPLORATION

Dans cette partie, essayez les manipulations à l’aide d’un script 
ou de la ligne de commande. Après chaque étape, observez le registre 
dans Regedit.

-----------------------------------------------------------
a) Obtenir le chemin du papier peint (Wallpaper)
   Clé : HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\System
   Valeur : Wallpaper
-----------------------------------------------------------
#>

$Path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\System"
$ValueName = "Wallpaper"
$WallpaperPath = Get-ItemPropertyValue -Path $Path -Name $ValueName
$WallpaperPath

<#
ATTENTION :
Dans Regedit, les racines sont HKEY_LOCAL_MACHINE\ et HKEY_CURRENT_USER\
En PowerShell, les PSDrives sont utilisés :
HKLM:\ et HKCU:\

Cette syntaxe est INCORRECTE :
$Path = "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\System"
(Get-ItemPropertyValue -Path $Path ...)  → Erreur
#>

<# 
-----------------------------------------------------------
b) Vérifier si la clé HKCU:\SOFTWARE\Automatisation existe
-----------------------------------------------------------
#>

Test-Path -Path "HKCU:\SOFTWARE\Automatisation"

<#
-----------------------------------------------------------
c) Créer la clé Automatisation sous HKCU:\SOFTWARE
-----------------------------------------------------------
#>

$Path = "HKCU:\SOFTWARE\Automatisation"
$NewKey = New-Item -Path $Path -Force
Test-Path -Path $Path

<#
-----------------------------------------------------------
d) Créer une valeur "Papier peint" (String) contenant le chemin obtenu
-----------------------------------------------------------
#>

$NewKey | New-ItemProperty -Name "Papier peint" -PropertyType "String" -Value $WallpaperPath

<#
-----------------------------------------------------------
e) Vérifier si la valeur "Nombre" existe (booléen)
-----------------------------------------------------------
#>

$Path = "HKCU:\SOFTWARE\Automatisation"
$ValueName = "Nombre"
[bool](Get-ItemProperty -Path $Path -Name $ValueName -ErrorAction Ignore)

<#
-----------------------------------------------------------
f) Créer une valeur DWORD "Nombre" = 0
-----------------------------------------------------------
#>

 $NewValueSplat = @{
     Path = "HKCU:\SOFTWARE\Automatisation"
     Name = "Nombre"
     PropertyType = "Dword"
     Value = 0
 }
 New-ItemProperty @NewValueSplat -Force | Out-Null

<#
-----------------------------------------------------------
g) Obtenir la valeur Nombre dans une variable
-----------------------------------------------------------
#>

$NombreSplat = @{
    Path = "HKCU:\SOFTWARE\Automatisation"
    Name = "Nombre"
}
$Nombre = Get-ItemPropertyValue @NombreSplat

<#
-----------------------------------------------------------
h) Incrémenter la valeur Nombre et l’enregistrer
-----------------------------------------------------------
#>

$Nombre++
Set-ItemProperty @NombreSplat -Value $Nombre

<#
-----------------------------------------------------------
i) Effacer la valeur Nombre
-----------------------------------------------------------
#>

Remove-ItemProperty @NombreSplat

<#
-----------------------------------------------------------
j) Effacer la clé HKCU:\SOFTWARE\Automatisation et tout son contenu
-----------------------------------------------------------
#>

# Remove-Item -Path "HKCU:\SOFTWARE\Automatisation" -Force

<# 
===========================================================
PARTIE 2 — DÉFI
===========================================================

Faire un script qui compte le nombre de fois qu'il est exécuté.

Emplacement du compteur :
  Clé : HKEY_CURRENT_USER\SOFTWARE\Automatisation
  Nom de la valeur : Compteur
  Type : DWord

Comportement :
 - Si c’est la première exécution → créer Compteur = 1
 - Sinon → incrémenter
 - Avec -Reset → remettre Compteur à 0

Exemple :

PS C:\> .\compteur.ps1
J'ai été exécuté 1 fois!

PS C:\> .\compteur.ps1
J'ai été exécuté 2 fois!

PS C:\> .\compteur.ps1 -Reset
Compteur réinitialisé!

===========================================================
#>
