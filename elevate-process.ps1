  $psi = new-object System.Diagnostics.ProcessStartInfo
  $psi.Verb = "runas";

  #if we pass no parameters, then launch PowerShell in the current location
  if ($args.length -eq 0)
  {
    $psi.FileName = 'powershell'
    $psi.Arguments = 
      "-NoExit -Command &{set-location '" + (get-location).Path + "'}"
  }

  #if we pass in a folder location, then launch powershell in that location
  elseif (($args.Length -eq 1) -and 
          (test-path $args[0] -pathType Container))
  {
    $psi.FileName = 'powershell'
    $psi.Arguments = 
        "-NoExit -Command &{set-location '" + (resolve-path $args[0]) + "'}"
  }

  #otherwise, launch the application specified in the arguments
  else
  {
    $file, [string]$arguments = $args;
    $psi.FileName = $file  
    $psi.Arguments = $arguments
  }
    
  [System.Diagnostics.Process]::Start($psi) | out-null
