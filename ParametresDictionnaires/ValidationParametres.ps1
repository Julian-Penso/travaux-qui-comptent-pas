# ===================== 3. VALIDATION DES PARAMÈTRES ==================

# Le script suivant est utilisé par les policiers lorsqu'ils interpellent
# un(e) automobiliste pour excès de vitesse. Il doit produire en sortie
# un objet qui contient l'information de l'incident :
#
# - Nom (obligatoire)
# - Prenom (obligatoire)
# - NoPermis (format : X9999-999999-99)
# - TypeVehicule (Voiture, Camion, Moto, Autobus, Autre)
# - Immatriculation (si spécifié : longueur 2 à 7 caractères)
# - Confiscation (switch)
# - Infraction (texte)
# - Points (entier entre 0 et 30)
#
# Vous devez ajouter les validations correspondantes.
param(
    [Parameter(Mandatory=$true)][string]$Nom,
    [Parameter(Mandatory=$true)][string]$Prenom,
    [ValidatePattern('^[A-Z][0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9][0-9][0-9]-[0-9][0-9]')][string]$NoPermis,
    [ValidateSet('Voiture','Camion','Moto','Autobus','Autre')][string]$TypeVehicule,
    [Parameter(Mandatory=$false)][ValidateLength(2,7)][string]$Immatriculation,
    [Switch] $Confiscation,
    [string] $Infraction,
    [ValidateRange(0,30)][Int]$Points
)
