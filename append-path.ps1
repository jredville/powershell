$local:command_usage =
"usage: append-path path-to-be-added
"

if ($args.length -lt 1) { return ($command_usage) }

$local:oldPath = get-content Env:\Path
$local:newPath = $local:oldPath + ";" + $args
set-content Env:\Path $local:newPath
