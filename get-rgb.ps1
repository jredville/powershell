$i = [int]$args[0]
if ($i -eq 0x02000000) {
  "default"
} else {
  $r = ($i -band 0xFF)
  $g = (($i -band 0xFF00) / 0x100)
  $b = (($i -band 0xFF0000) / 0x10000)
  "($r,$g,$b)"
}