$local:command_usage =
"usage: prepend-path path-to-be-added
"

if ($args.length -lt 1) { return ($command_usage) }

$local:oldPath = get-content Env:\Path
$local:newPath = $args[0].ToString() + ";" + $local:oldPath
set-content Env:\Path $local:newPath
