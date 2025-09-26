#Écrivez une fonction Start-Notepad qui démarre Notepad.exe à l'aide de Start-Process et retourne un objet décrivant le processus dans le pipeline.
function Start-Notepad {
    Start-Process Notepad.exe
    return Get-Process -name Notepad
}

Start-Notepad