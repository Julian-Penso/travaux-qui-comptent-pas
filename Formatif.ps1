param(
    [ValidateScript({$_.Length -gt 10})]
    [string]$Phrase
)

$a = $Phrase.Split(" ")
$b = 0

foreach($z in $a) {
    $b = $b + $z.Length
}
Write-Host $b