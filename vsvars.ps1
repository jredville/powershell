param([string]$version = "9.0")

if (test-path HKLM:SOFTWARE\Wow6432Node\Microsoft\VisualStudio\$version) {
	$VsKey = get-itemproperty HKLM:SOFTWARE\Wow6432Node\Microsoft\VisualStudio\$version
}
else {
	if (test-path HKLM:SOFTWARE\Microsoft\VisualStudio\$version) {
		$VsKey = get-itemproperty HKLM:SOFTWARE\Microsoft\VisualStudio\$version
	}
}
    $VsInstallPath = [System.IO.Path]::GetDirectoryName($VsKey.InstallDir)
    $VsToolsDir = [System.IO.Path]::GetDirectoryName($VsInstallPath)
    $VsToolsDir = [System.IO.Path]::Combine($VsToolsDir, "Tools")
    $BatchFile = [System.IO.Path]::Combine($VsToolsDir, "vsvars32.bat")
    Get-Batchfile $BatchFile
    "Visual Studio $version Configured"
