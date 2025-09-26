function Invoke-Addition{
    param(
        [double[]] $termes
    )

    $total = 0

    foreach ($terme in $termes) {
        $total += $terme
    }

    $total
}

Invoke-Addition 2,3,5


. .\Invoke-Addition.PS1

Invoke-Addition -termes 2,4,6