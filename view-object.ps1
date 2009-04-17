# Objectviewer.msh 
# will show an Object in a PropertyGrid (propertywindow in Visual Studio) 
# this is an easy way to look at MSH objects. 
# you can read / write the object properties. 
# and it has some nice editors for some properties 
# eg. ov (gi test.txt)will let you change the date by a calendarview 
# /\/\o\/\/ 2005 

[void][System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") 

$form = new-object "System.Windows.Forms.Form" 
$form.Size = new-object System.Drawing.Size @(600,600) 
$PG = new-object "System.Windows.Forms.PropertyGrid" 
$PG.Dock = [System.Windows.Forms.DockStyle]::Fill 
$form.text = "$args" 
$PG.selectedobject = $args[0].psObject.baseobject 
$form.Controls.Add($PG) 
$form.topmost = $true 
$form.showdialog() 
