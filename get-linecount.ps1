param ( [string] $match="*.cs" )
$re = "^((?!\s*//.*).)*$"
(get-childitem -i $match -r | grep $re | where-object { $_.Line.Trim() -ne "" }).Count
