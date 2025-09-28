param( 
    [Parameter(Mandatory=$true)][int[]]$Termes
)
$Resultat = 0
foreach ($terme in $Termes) 
{
    if ($Resultat -eq 0) 
    {
        $Resultat = $terme
    }
    else 
    {
        $Resultat = $Resultat * $terme
    }
}

Write-Output $Resultat