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


# Étape B : Extraire le fichier ZIP
# - Utiliser Expand-Archive ou la méthode avec System.IO.Compression.ZipFile
# - Extraire dans $HOME\Desktop\Outils



# ================================================================
# 🌐 Exercice 2 – API publique (ip-api.com)
# ================================================================

# Étape A : Obtenir ton adresse IP publique et ton fournisseur Internet
# - Utiliser Invoke-WebRequest OU Invoke-RestMethod
# - Extraire les champs JSON nécessaires

# Étape B : Trouver la ville correspondant à ton adresse IP publique
# - Lire le champ "city"

# Étape C : Trouver la ville de l’adresse IP 8.8.8.8
# - Refaire la requête avec cette IP

# Étape D : Ouvrir Google Maps à la position géographique de 8.8.8.8
# - Utiliser les champs "lat" et "lon"
# - Formater les décimales avec [CultureInfo]::InvariantCulture
# - Construire une URL Google Maps
# - L’ouvrir avec Start-Process

# Étape E : Obtenir seulement certains champs (query et reverse)
# - Utiliser le paramètre "fields=" dans l’URL

# Étape F : Requête POST pour plusieurs IPs
# - Construire un tableau d’adresses IP
# - Définir les champs à demander
# - Construire un objet JSON à partir d’un dictionnaire ou PSCustomObject
# - Envoyer la requête avec Invoke-RestMethod -Method Post



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
