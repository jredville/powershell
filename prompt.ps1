Write-Host $(get-location) -foregroundcolor gray

$nextId = (get-history -count 1).Id + 1;
$currentPath = (get-location).Path.replace($home, "~")
$idx = $currentPath.IndexOf("::")
if ($idx -gt -1) { $currentPath = $currentPath.Substring($idx + 2) }
write-host ("[" + $nextId + "] ") -NoNewLine -ForegroundColor Green
if ((get-location -stack).Count -gt 0) { write-host ("+" * ((get-location -stack).Count) + " ") -NoNewLine -ForegroundColor Yellow }
write-host ("»") -NoNewLine -ForegroundColor Green

return " "