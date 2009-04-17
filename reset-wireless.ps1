$wireless = Get-WmiObject win32_NetworkAdapter | where { $_.Name.Contains("Wireless") }
$wireless.Disable()
Sleep(8)
$wireless.Enable()
