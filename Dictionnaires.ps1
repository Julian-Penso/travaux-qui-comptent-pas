
# ===================== 2. DICTIONNAIRES ==============================

# A) Dans une variable, créez la structure suivante :
#    Nom        : Skywalker
#    Prenom     : Luke
#    Profession : Jedi
$Jedi = [PSCustomObject]@{
    Nom = "Skywalker";
    Prenom = "Luke";
    Profession = "Jedi";
}
$Jedi | Format-List

# B) Faites une variable qui contient ces trois personnages :
#    Skywalker Luke    Jedi
#    Kenobi    Obi Wan Jedi
#    Yoda      Minch   Jedi
$Jedis = 
@(
 [PSCustomObject]@{
    Nom = "Skywalker";
    Prenom = "Luke";
    Ordre = "Jedi";}
    [PSCustomObject]@{
        Nom = "Kenobi";
        Prenom = "Obi Wan";
        Ordre = "Jedi"}
    [PSCustomObject]@{
        Nom = "Yoda";
        Prenom = "Minch";
        Ordre = "Jedi";}
)
$Jedis | Format-Table



# C) Ajoutez Darth Vader à ce tableau :
#    Vader Darth Sith
$Jedis += [PSCustomObject]@{
    Nom = "Vader"
    Prenom = "Darth"
    Ordre = "Sith"
}
$Jedis

# D) Dressez la liste de tous les Jedis seulement.
$Jedis | Where-Object {$_.Ordre -eq "Jedi"} | Format-Table

# E) Faites un script qui produit un personnage et l'envoie
#    dans le pipeline.
#    Exemple :
#      .\monscript.ps1 -Nom "Solo" -Prenom "Han" -Profession "Contrebandier"

.\AjoutPersonnage.ps1 -Nom "Solo" -Prenom "Han" -Ordre "Contrebandier"

# F) Appelez ce script en utilisant la technique du Splatting.
$isplat = @{
    FilePath = .\AjoutPersonnage.ps1
    Nom = "Solo"
    Prenom = "Han"
    Ordre = "Contrebandier"
}
$isplat
