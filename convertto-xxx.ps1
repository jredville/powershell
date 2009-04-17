#requires -version 2.0 
param( 
[Parameter(ParameterSetName="xxx", Mandatory=$true, Position=0)] 
$InputObject,

[Parameter(ParameterSetName="xxx", Mandatory=$true)] 
$yProperty,

[Parameter(ParameterSetName="xxx", Mandatory=$true)] 
$xProperty,

[Parameter(ParameterSetName="xxx")] 
[ScriptBlock] 
$CellValue = {"TRUE"},

[Parameter(ParameterSetName="xxx")] 
$NullValue = "-",

[Parameter(ParameterSetName="TEST", Mandatory=$true)] 
[Switch] 
$Test 
)

    function Assert 
    { 
    param( 
        [Parameter(Mandatory=$true, Position=0)] 
        [ScriptBlock]$script, 
        [Parameter(Position=1)] 
        $Message=$null 
    ) 
        if (!(&$script)) 
        { 
            $ThrowAway,$stack = Get-PscallStack 
            $msg = @" 
    ASSERT( $script ) FAILED at 
    $($stack | out-string)

    $Message 
    Continue script execution? 
"@ 
            if ( !($pscmdlet.ShouldContinue($msg, "ASSERT FAILED"))) 
            { 
                exit 
            } 
        } 
    }

    function Add-Property 
    { 
    param( 
        [Parameter(Mandatory=$true, Position=0)] 
        [ValidateNotNullOrEmpty()] 
        $obj, 
        [Parameter(Mandatory=$true, Position=1)] 
        [ValidateNotNullOrEmpty()] 
        [String] 
        $prop, 
        [Parameter(Mandatory=$true, Position=2)] 
        $value) 
        Add-Member -InputObject $obj -MemberType NoteProperty -Name $prop -Value $value -Force 
    }

if ($PSCmdlet.ParameterSetName -eq "TEST") 
{ 
    foreach ($snapin in Get-PSSnapin) { 
        Write-output $snapin.Name 
        $InputObject = get-command -PSSnapin $snapin -type Cmdlet |sort noun 
         &$MyInvocation.MyCommand.Path  $InputObject -nullValue "*" -YProperty Verb  -xProperty Noun -CellValue {$args[0].name}|ft -auto |out-string –stream  
    } 
    exit    
}

foreach ($group in $InputObject | Group-Object -Property $yProperty |Sort Name) 
{ 
   $outObj = New-Object psobject 
   Add-Property $outObj Name $group.Name 
   foreach ($inObj in $InputObject) 
   { 
        $Xname = $inObj.$xProperty 
        Assert {$Xname } "Property [$XProperty] not found on input object" 
        Assert {$Xname -ne "NAME" } "Cannot have 'Name' as a property" 
        if ($InObj.$yProperty -eq $group.Name) 
        {            
            Add-Property $outObj $Xname (&$CellValue $inObj) 
        }elseif (!$outObj.$XName) 
        { 
            Add-Property $outObj $Xname  $nullValue 
        } 
   } 
   Write-Output $outObj 
}
