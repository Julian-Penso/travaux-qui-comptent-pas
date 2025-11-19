# Objectif : retourner un tableau de toutes les adresses IPv4
# Classe utile : Win32_NetworkAdapterConfiguration
# Indice : IPAddress contient un tableau
# Filtrer : seulement les adresses IPv4 (format X.X.X.X)

# Ton code ici
$NetworkConfig = Get-CimInstance Win32_NetworkAdapterConfiguration 
Foreach ($Config in $NetworkConfig){
    if ($Config.IPEnabled -eq $false) 
    {continue}
    $Config.IPAddress[0]
}