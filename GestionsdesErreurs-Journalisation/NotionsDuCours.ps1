# ================================
# 420-3T5-EM — Rencontré #11
# Erreurs & Journalisation — Notions-résumé (à coder dessous)
# ================================
# Au programme :
# - Gestion des erreurs
# - Fichiers journaux (logs)
# ------------------------------------------------------------


# ================================
# PRÉVENTION / CONTEXTE DES ERREURS
# ================================
# - Les erreurs sont inévitables (fichier absent/corrompu, permissions, verrou, serveur down, etc.)
# - Danger d’un travail incomplet si le script stoppe au milieu.
# - Objectif : prévoir et réagir proprement (valider paramètres, tester conditions de succès, journaliser).
# ------------------------------------------------------------


# ================================
# TYPES D’ERREURS EN POWERSHELL
# ================================
# - Terminating   : arrête immédiatement l’exécution.
# - Non-terminating : affiche un message mais continue l’exécution.
# - Les erreurs sont des ErrorRecord (stream 2) et s’empilent dans $Error (dernier = $Error[0]).
        Get-Service -Name Bonjour 
        $Error[0] | Get-Member # voir les propriétés/méthodes
        $Error[0].Exception # message d’erreur
#   Propriétés utiles : Exception(.Message, .GetType()), FullyQualifiedErrorId, CategoryInfo,
#   TargetObject, InvocationInfo (ScriptLineNumber, ScriptName, Line), ScriptStackTrace.
# ------------------------------------------------------------


# ================================
# COMPORTEMENTS FACE AUX ERREURS
# ================================
# - $ErrorActionPreference contrôle le comportement global (par défaut: "Continue").
#   Valeurs possibles : Stop | Continue | SilentlyContinue | Ignore | Inquire

        $ErrorActionPreference # par défaut "Continue"

        $ErrorActionPreference = "SilentlyContinue" # ne montre rien
        Get-ChildItem C:\minou.txt # pas d'erreur affichée
        $Error[0] # mais l'erreur est bien enregistrée dans $Error

        $ErrorActionPreference = "ignore" # n'enregistre même pas l'erreur
        Get-ChildItem C:\pitou.txt # pas d'erreur affichée ni enregistrée
        $Error[0] # pas de nouvelle erreur enregistrée

# - Paramètre commun -ErrorAction pour cibler commande par commande.

        $ErrorActionPreference = "SilentlyContinue" 
        #Je veux quelle plante quand même
        Get-ChildItem C:\minou.txt -ErrorAction Stop # plante ici

# - -ErrorVariable pour capter l’erreur dans une variable (ex.: -ErrorVariable err).
        Get-ChildItem C:\minou.txt -ErrorAction SilentlyContinue -ErrorVariable erreur # capture l'erreur dans la variable "$erreur"
        $erreur # contient l'erreur
# ------------------------------------------------------------


# ================================
# VARIABLES UTILES
# ================================
# - $? : booléen succès/échec de la DERNIÈRE commande ($true/$false).<
            Get-ChildItem C:\minou.txt -ErrorAction SilentlyContinue -ErrorVariable erreurs
            $? # false car la commande a échoué
            Get-ChildItem C:\Windows
            $? # true car la commande a réussi

# - $LASTEXITCODE : code de retour d’un processus externe (0 = succès par convention).
# - $Error : pile d’objets ErrorRecord (dernier en [0]).
# ------------------------------------------------------------


# ================================
# STRUCTURES DE GESTION D’ERREURS
# ================================
# 1) Trap {...}  # nécessite que l’erreur soit « Stop » pour être capturée
#    - Peut utiliser 'continue' pour poursuivre après le piège.
        # exemples :
        trap {
            Write-Host "Une erreur est survenue dans le trap : $($_.Exception.Message)"
            continue
        }
#
# 2) Try { ... } Catch { ... } [Finally { ... }]
#    - Flexible, recommandé.
#    - L’erreur doit être terminale (Stop) pour entrer dans Catch.
#    - Plusieurs Catch possibles pour différents types d’erreurs.
#    - Finally s’exécute toujours (utile pour nettoyage).
        $ErrorActionPreference = "Stop" # pour que les erreurs soient terminales
        try {
            Get-ChildItem C:\minou.txt 
        }
        catch {
            Write-Host "Une erreur est survenue dans le try/catch : $($_.Exception.Message)"
        }
        finally {
            Write-Host "Le bloc finally s'exécute toujours."
        }
#
# Bonnes pratiques :
# - Mettre dans Try les commandes interdépendantes.
# - Option « gros Try » : envelopper la tâche unique du script pour gérer l’erreur globale et logguer.


# - Laisser l’appelant décider : respecter -ErrorAction, relancer ce qui n’est pas traitable.
# ------------------------------------------------------------


# ================================
# LANCER ET GÉNÉRER DES ERREURS
# ================================
# - throw  : lance une erreur TERMINALE (RuntimeException).
         if ((Get-Date).Minute % 2 -eq 1) { throw "Minute impaire détectée !" }
# - Write-Error : lance une erreur NON-TERMINALE (devient terminale si $ErrorActionPreference='Stop').
       1..3 | ForEach-Object { Write-Error "Erreur numéro $_" } # Non-terminale
# - Ciblage par classes d’exception dans Catch : 
#   catch [System.IO.IOException] { ... } ; catch { ... }  # du plus spécifique au plus général
# ------------------------------------------------------------


# ================================
# COMMANDES EXTERNES & CODES DE RETOUR
# ================================
# - Les .exe (ex.: ping.exe) n’émettent pas d’ErrorRecord : try/catch ne capture pas l’échec.
# - Utiliser $? et $LASTEXITCODE pour savoir si la commande a réussi.
# - Convention : 0 = succès, autre = échec (parfois valeur spéciale, ex.: 3010 = reboot requis).
# - Terminer le script avec un code précis : exit(0) | exit(1) | exit(1701)
# ------------------------------------------------------------
ping 192.168.9.900 -n 1
$LASTEXITCODE # code de retour de ping (1 = échec car IP invalide)
ping 8.8.8.8 -n 1
$LASTEXITCODE # code de retour de ping (0 = succès car IP valide)
try {
    ping 192.168.9.900 -n 1
}
catch {
    # le bloc catch ne sera pas exécuté car ping n'est pas une cmdlet PowerShell!!
    Write-Host "Une erreur est survenue lors du ping : $($_.Exception.Message)" 
}


# ================================
# JOURNALISATION (LOGS)
# ================================
# - Fichier texte .log listant opérations (aide au débogage).
# - Structure classique : Timestamp | Level | Message 
# - Bonnes pratiques :
#   * Niveau de détail adapté (service critique → plus verbeux).
#   * Rotation : éviter que le log grossisse à l’infini (renommer/archiver/écraser ancien).
#   * Emplacement : variables d’environnement, pas de chemins hardcodés, attention aux permissions.
#       - Exemples sûrs utilisateur : $env:TEMP, $env:APPDATA
#       - Éviter C:\, Program Files, System32 sans admin.
#   * Pour prendre l’emplacement du script : $PSScriptRoot (si exécuté depuis un .ps1)
#     Sinon fallback sur (Get-Location).Path
# ------------------------------------------------------------
"miaou" | Add-Content -Path $env:temp\minou.log # exemple d'écriture dans un log
"$env:temp\minou.log"

# ================================
# SQUELETTE D’UNE FONCTION DE LOG
# ================================
# TODO: Implémente Write-Log :
# - Paramètre obligatoire [string]$Message, pipeline input accepté.
# - Paramètre [ValidateSet('Info','Warning','Error')]$Level = 'Info'
# - Dossier : Join-Path $env:TEMP 'MonJournal'  (créer si absent)
# - Fichier : 'MonJournal.log' (UTF8)
# - Timestamp via Get-Date -Format 'yyyy-MM-dd HH:mm:ss.fff'
# - Aligner les colonnes (ex.: $Level.PadRight(7)) pour "Info/Warning/Error"
# - Ajouter la rotation : si taille > 1KB → renommer en .lo_ puis repartir à neuf.
# - Exemples d’appels :
#     Write-Log -Message "Étape X" -Level Info
#     "Depuis le pipeline" | Write-Log
# ------------------------------------------------------------


# ================================
# ZONE D’EXERCICES GUIDÉS (à relier aux notions)
# ================================
# [Gestion des erreurs]
# - Fixer $ErrorActionPreference = 'Stop' AU DÉBUT, ou laisser l’appelant décider.
# - Tenter une opération sujette à erreur dans Try ; Catch : journaliser détails via $_ :
#     $_.Exception.Message
#     $_.InvocationInfo.ScriptLineNumber
#     $_.InvocationInfo.ScriptName
#     $_.InvocationInfo.Line
#     $_.CategoryInfo.Category
# - Relancer (throw) si l’erreur est hors de contrôle après log.
# ------------------------------------------------------------
# [Commandes externes]
# - Exécuter un .exe, vérifier $? et $LASTEXITCODE, écrire au log en conséquence.
# ------------------------------------------------------------
# [Sortie du script]
# - exit(0) si tout OK ; exit(1) si erreur critique non traitable (après log).
# ------------------------------------------------------------


# ================================
# À TOI DE CODER ICI ↓↓↓
# ================================
