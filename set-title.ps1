$local:command_usage =
"usage: set-title title-text
"

if ($args.length -lt 1) { return ($command_usage) }
$host.UI.RawUI.WindowTitle = $args[0]
