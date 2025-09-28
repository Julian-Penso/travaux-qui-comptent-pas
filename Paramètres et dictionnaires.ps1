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


# ===================== 2. DICTIONNAIRES ==============================

# A) Dans une variable, créez la structure suivante :
#    Nom        : Skywalker
#    Prenom     : Luke
#    Profession : Jedi


# B) Faites une variable qui contient ces trois personnages :
#    Skywalker Luke    Jedi
#    Kenobi    Obi Wan Jedi
#    Yoda      Minch   Jedi


# C) Ajoutez Darth Vader à ce tableau :
#    Vader Darth Sith


# D) Dressez la liste de tous les Jedis seulement.


# E) Faites un script qui produit un personnage et l'envoie
#    dans le pipeline.
#    Exemple :
#      .\monscript.ps1 -Nom "Solo" -Prenom "Han" -Profession "Contrebandier"


# F) Appelez ce script en utilisant la technique du Splatting.


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

# ====================================================================
# Écris ton code sous chaque bloc d'énoncé !
# ====================================================================
