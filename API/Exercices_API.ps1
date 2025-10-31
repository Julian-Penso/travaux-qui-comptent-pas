# ================================================================
# 420-3T5-EM – Automatisation de tâches
# Exercices – Requêtes Web et API REST
# Auteur : Julian Penso
# ================================================================


# ================================================================
# 🧩 Exercice 1 – Téléchargement d’un fichier Zip (Sysinternals)
# ================================================================

# Étape A : Télécharger le fichier ZIP des outils Sysinternals
# - Utiliser Invoke-WebRequest
# - Désactiver la barre de progression
# - Utiliser -UseBasicParsing si nécessaire
# - Sauvegarder dans $env:temp
$uri = "https://download.sysinternals.com/files/SysinternalsSuite.zip"
$dest = "$env:TEMP"
$zipPath = Join-Path -Path $dest -ChildPath "SysinternalsSuite.zip"
$dossierSysinternals = Join-Path -Path $dest -ChildPath "SysinternalsSuite"

#Invoke-WebRequest -Uri $uri -OutFile $zipPath -UseBasicParsing
#Expand-Archive -Path $zipPath -DestinationPath $dossierSysinternals


# Étape B : Extraire le fichier ZIP
# - Utiliser Expand-Archive ou la méthode avec System.IO.Compression.ZipFile
# - Extraire dans $HOME\Desktop\Outils
#Expand-Archive -Path $zipPath -DestinationPath $dossierSysinternals
#Move-Item -Path $dossierSysinternals -Destination $HOME\Desktop\Outils

# ================================================================
# 🌐 Exercice 2 – API publique (ip-api.com)
# ================================================================

# Étape A : Obtenir ton adresse IP publique et ton fournisseur Internet
# - Utiliser Invoke-WebRequest OU Invoke-RestMethod
# - Extraire les champs JSON nécessaires
$uri = "http://ip-api.com/json/"
$response = Invoke-WebRequest -Uri $uri -UseBasicParsing 
$data = $response.Content | ConvertFrom-Json
Write-Host $data.query
Write-Host $data.isp
# Étape B : Trouver la ville correspondant à ton adresse IP publique
# - Lire le champ "city"
Write-Host $data.city

# Étape C : Trouver la ville de l’adresse IP 8.8.8.8
# - Refaire la requête avec cette IP
$uri2 = "http://ip-api.com/json/8.8.8.8"
$response2 = Invoke-WebRequest -Uri $uri2 -UseBasicParsing
$data2 = $response2.Content | ConvertFrom-Json
Write-Host $data2.city

# Étape D : Ouvrir Google Maps à la position géographique de 8.8.8.8
# - Utiliser les champs "lat" et "lon"
# - Formater les décimales avec [CultureInfo]::InvariantCulture
# - Construire une URL Google Maps
# - L’ouvrir avec Start-Process
$latitude = $data2.lat
$longitude = $data2.lon
$latFormatté = $latitude.ToString([Cultureinfo]::InvariantCulture)
$lonFormatté = $longitude.ToString([Cultureinfo]::InvariantCulture)
$googlemapsUrl = "https://www.google.com/maps/search/?api=1&query=$latFormatté,$lonFormatté"
#Start-Process $googlemapsUrl


# Étape E : Obtenir seulement certains champs (query et reverse)
# - Utiliser le paramètre "fields=" dans l’URL
$uri3 = "http://ip-api.com/json/?fields=query,reverse"
$response3 = Invoke-WebRequest -Uri $uri3 -UseBasicParsing
$data3 = $response3.Content | ConvertFrom-Json
#Write-Host "IP:" $data3.query
#Write-Host "Reverse DNS:" $data3.reverse
# Étape F : Requête POST pour plusieurs IPs
# - Construire un tableau d’adresses IP
# - Définir les champs à demander
# - Construire un objet JSON à partir d’un dictionnaire ou PSCustomObject
# - Envoyer la requête avec Invoke-RestMethod -Method Post
$ips = @(
        [PSCustomObject]@{
            ip = 1.1.1.1
        },
        [PSCustomObject]@{
            ip = 8.8.8.8
        },
        [PSCustomObject]@{
            ip =8.8.4.4
        }
)
$body = $ips | ConvertTo-Json
$uri4 = "http://ip-api.com/batch"
$response4 = Invoke-RestMethod -Uri $uri4 -Method Post -Body $body -ContentType "application/json"
$response4 


# ================================================================
# 🔐 Exercice 3 – API de pfSense (pfrest)
# ================================================================

# Étape A : Définir l’URI du serveur pfSense
# - Exemple d’adresse : http://192.168.21.1/api/v2/status/interfaces

# Étape B : Obtenir les identifiants d’utilisateur
# - Utiliser Get-Credential

# Étape C : Envoyer la requête REST avec authentification Basic
# - Utiliser Invoke-RestMethod
# - Ajouter -AllowUnencryptedAuthentication (HTTP non sécurisé)

# Étape D : Afficher les données utiles (interface WAN, IP, masque, passerelle, MAC)
# - Sélectionner les champs pertinents de la réponse

# ⚠️ Note : En environnement réel, utiliser HTTPS et une méthode d’autorisation plus sécurisée (OAuth2/Bearer).
