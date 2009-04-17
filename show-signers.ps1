$inputs = $(get-childitem)

foreach ($file in $inputs)
{
    # skip directories
    if ($file.PSIsContainer) {continue}

	$sig = get-authenticodesignature $file.Name
	$signer = $sig.SignerCertificate.Subject
      
      
	if ($signer -match "^CN=")
	{
		#regex to rip out the common name from subject
		$reg = [regex] "CN=([^,]*),"
		
		# get the match object
		$matches = $($reg.Matches($signer))
		
		if ($matches.Success)
		{
			# pull out the captured group from the regex above
			$signer = $matches.Groups[1].Value
		}
	}
	
	1 | select-object @{expression = {$file.Name}; name = "Name"}, @{expression = {$signer}; name = "Signer"}
}
