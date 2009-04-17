Clear-Host

$x = $host.UI.RawUI.WindowSize
$x.Width = 80
$x.Height = 25
$host.UI.RawUI.WindowSize = $x

$x = $host.UI.RawUI.BufferSize
$x.Width = 80
$host.UI.RawUI.BufferSize = $x
