param ( [string]$comp = "." , [switch]$all)
$size = @{ l = "Size (MB)"; e = { $_.size/1mb};      f = "{0:N}"}
$free = @{ l = "free (MB)"; e = { $_.freespace/1mb}; f = "{0:N}"}
$perc = @{ l = "Percent"; e = { 100.0 * ([double]$_.freespace/[double]$_.size)}; f="{0:f}" }
$name = @{ e = "name"; f = "{0,-20}" }
$fields = $name,$size,$free,$perc
$filter = "DriveType = '3'"
if ( $all ) { $filter = "" }
get-wmiobject -class win32_logicaldisk -filter $filter -comp $comp | format-table $fields -auto
