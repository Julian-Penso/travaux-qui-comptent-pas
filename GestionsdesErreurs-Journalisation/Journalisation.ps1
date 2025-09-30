# ================================
# 2. JOURNALISATION
# ================================

# a) Écrire une fonction Write-Log
#    - Paramètre obligatoire Message (peut venir du pipeline)
#    - Écrit dans un fichier MonJournal.log
#         situé dans $env:TEMP\MonJournal\
#         (créer le dossier si nécessaire)
#    - Préfixer chaque message d’un timestamp (Get-Date)
#    - Tester la fonction en l’appelant plusieurs fois
# --------------------------------------------------


# b) Ajouter un paramètre -Level (Info, Warning, Error)
#    - Par défaut: Info
#    - Utiliser [ValidateSet()] pour restreindre les valeurs
#    - Aligner les colonnes avec .PadRight()
# --------------------------------------------------


# c) Défi +++
#    Implémenter une rotation automatique du fichier log:
#    - Si MonJournal.log > 1 Ko, renommer en MonJournal.lo_
#    - Recréer un nouveau MonJournal.log
# --------------------------------------------------