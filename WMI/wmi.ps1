# a) Fuseau horaire
# Classe utile : Win32_TimeZone
# Commande de base :
$Ordinateur = Get-CimInstance Win32_ComputerSystem
# Get-CimInstance <classe> | Select-Object <propriété>
Get-CimInstance Win32_TimeZone | Select-Object Description

# b) Fabricant de l’ordinateur
# Classe utile : Win32_ComputerSystem
$Ordinateur = Get-CimInstance Win32_ComputerSystem
$Ordinateur | Select-Object Manufacturer


# c) Modèle de l’ordinateur
# Classe utile : Win32_ComputerSystem
$Ordinateur | Select-Object Model


# d) Version de Windows installée
# Classe utile : Win32_OperatingSystem
Get-CimInstance Win32_OperatingSystem | Select-Object Caption,Version

# e) Version du BIOS
# Classe utile : Win32_BIOS
Get-CimInstance Win32_BIOS | Select-Object BIOSVersion


# f) Numéro de série de la machine
# Classe utile : Win32_BIOS
Get-CimInstance Win32_BIOS | Select-Object SerialNumber

# g) Date d’installation du système d’exploitation
# Classe utile : Win32_OperatingSystem
Get-CimInstance Win32_OperatingSystem | Select-Object InstallDate


# h) Modèle du processeur
# Classe utile : Win32_Processor
Get-CimInstance Win32_Processor | Select-Object Name

# i) Quantité de mémoire RAM (Go)
# Classe utile : Win32_ComputerSystem
# Indice : la propriété est en bytes → divise par 1GB → arrondis
$Ordinateur | ForEach-Object {
    $_.TotalPhysicalMemory / 1GB -as [int]
}
# j) Mises à jour Windows installées
# Classe utile : Win32_QuickFixEngineering
# Sélectionner : HotFixID, InstalledOn
Get-CimInstance Win32_QuickFixEngineering | Select-Object HotFixID, InstalledOn



# k) Liste des périphériques USB
# Classe utile : Win32_USBDevice
# Sélectionner : Caption, PNPDeviceID
Get-CimInstance Win32_USBControllerDevice | Select-Object Caption, PNPDeviceID


# l) Produits Microsoft avec licence active
# Classe utile : SoftwareLicensingProduct
# Filtrer LicenseStatus = 1
# Sélectionner : Name, PartialProductKey
Get-CimInstance SoftwareLicensingProduct | Where-Object { $_.LicenseStatus -eq 1 } | Select-Object Name, PartialProductKey
