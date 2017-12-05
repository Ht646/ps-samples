$c= get-content “C:\temp\workstations.txt” 

foreach ($i in $c)

{
get-wmiobject win32_operatingsystem -computer $i | select ` csname,caption,servicepackmajorversion,BuildNumber | ConvertTo-Html  > C:\temp\computerlist.html
}