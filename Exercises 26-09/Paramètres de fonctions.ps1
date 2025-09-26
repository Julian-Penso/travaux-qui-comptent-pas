#Écrivez une fonction Start-Notepad qui démarre Notepad.exe à l'aide de Start-Process et retourne un objet décrivant le processus dans le pipeline.
function Start-Notepad {
    Start-Process Notepad.exe
    return Get-Process -name Notepad
}

Start-Notepad

#B) Réécrivez la fonction précédente et faites en sorte qu'il soit possible de spécifier un fichier texte.
#info
#Pour ouvrir Notepad avec un fichier existant, il suffit de fournir le chemin complet du fichier texte à en argument (par exemple, notepad.exe "C:\dossier\fichier.txt"). Vous pouvez passer l'argument à la commande Start-Process à l'aide du paramètre -ArgumentList

function Start-Notepad {
    Start-Process Notepad.exe -ArgumentList "C:\Users\6288022\Documents\GitHub\travaux-qui-comptent-pas\Exercises 26-09\salut!.txt"
    return Get-Process -name Notepad
}
Start-Notepad

#C) Réécrivez la fonction précédente et faites en sorte qu'elle plante si le fichier n'existe pas. Utilisez les validations de paramètres.
function Start-Notepad {
    param(
        [Parameter(Mandatory)]
        [ValidateScript({
            if (Test-Path $_) {
                $true
            }
            else {
                throw "Le fichier '$_' est introuvable."
            }
        })]
        [string] $Path
    )

    Start-Process Notepad.exe -ArgumentList $Path
    return Get-Process -Name Notepad
}

Start-Notepad -Path "C:\Users\6288022\Documents\GitHub\travaux-qui-comptent-pas\Exercises 26-09\salut!.txt"

