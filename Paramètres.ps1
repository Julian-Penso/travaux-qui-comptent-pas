# ====================================================================
# 420-3T5-EM Automatisation de tâches
# Rencontre #9 – Paramètres et dictionnaires
# ====================================================================

# ===================== 1. PARAMÈTRES ================================

# A) Écrivez un script Multiplier.ps1 qui écrit dans le pipeline
#    le résultat de la multiplication de deux termes passés en paramètre.
#    Exemple :
#      .\Multiplier.ps1 -Terme1 3 -Terme2 5
#    Résultat attendu : 15
.\Multiplier.ps1 -Terme1 3 -Terme2 5


# B) Réécrivez le script précédent, mais de sorte que les paramètres
#    soient obligatoires.
#    Exemple :
#      .\Multiplier.ps1 -Terme1 3
#      -> invite pour Terme2, résultat : 15
.\Multiplier.ps1 -Terme1 4 -Terme2 16



# C) Réécrivez le script précédent, mais de sorte qu'il puisse admettre
#    un nombre illimité de nombres.
#    Exemple :
#      .\Multiplier.ps1 -Termes 3, 5, 2
#    Résultat attendu : 30
.\Multiplier.ps1 -Termes 3,5,2,3,4,4,5



# ====================================================================
# Écris ton code sous chaque bloc d'énoncé !
# ====================================================================
