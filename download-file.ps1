# Test
$webclient = new-object System.Net.WebClient
$start = $args[0].LastIndexOf("/") + 1
$len = $args[0].LastIndexOf("?") - $start
if( $len -lt 0 ) { $len = $args[0].Length - $start  }
$target = [System.IO.Path]::Combine( $(get-location), $args[0].Substring( $start, $len ) )
$webclient.DownloadFile($args[0], $target)
