# ================================
# 1. GESTION DES ERREURS
# ================================
# a) Écrivez un script qui prend en paramètre un ou plusieurs noms d'utilisateurs locaux
#    et affiche les informations de chaque utilisateur qui existe.
#    - Utiliser Get-LocalUser
#    - Aucune erreur ne doit apparaître à la console (ErrorAction SilentlyContinue)
#    - Les utilisateurs inexistants ne s’affichent pas
# --------------------------------------------------

.\utilisateurs.ps1 -Name "Administrateur", "PereNoel", "Invité"
$Error[0]

# b) Même principe que a), mais affiche si l'utilisateur existe ou non.
#    - Utiliser Get-LocalUser
#    - Affichage avec Write-Host
#    - Gérer avec Try / Catch
#    - Utiliser Out-Null pour se débarrasser des objets
# --------------------------------------------------

.\utilisateurs.ps1 -Name "Administrateur","UtilisateurInexistant","Invité"
$Error[0]

# c) Écrivez un script qui retourne une erreur lorsque les minutes sont impaires.
#    - Utiliser throw
# --------------------------------------------------


# d) Écrivez un script qui appelle le script précédent et intercepte cette erreur.
#    - Afficher du texte personnalisé avec Catch
# --------------------------------------------------


