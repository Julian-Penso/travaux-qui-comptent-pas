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

Invoke-Addition 2,4,5