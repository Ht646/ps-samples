# Inventory computers in the domain

$strComputerName = "SERV1"
$strReportsFolder = "C:\temp\Reports"

$strOutputFile = $strReportsFolder + "\" + $strComputerName + "-" + "Inventory" + ".txt"
write-host $strOutputFile
echo "====================== " > $strOutputFile
echo $strComputerName >> $strOutputFile
echo "====================== " >> $strOutputFile
echo "" >> $strOutputFile
date >> $strOutputFile
echo "" >> $strOutputFile
echo "" >> $strOutputFile

echo "******* Computer System"  >> $strOutputFile
get-WmiObject Win32_ComputerSystem -computername $strComputerName -ErrorAction SilentlyContinue `
       | Out-File -filepath $strOutputFile -append

echo "******* Processor"  >> $strOutputFile
get-WmiObject Win32_Processor -computername $strComputerName -ErrorAction SilentlyContinue `
       | format-List -property Name,Manufacturer,MaxClockSpeed,Caption,ProcessorId,SocketDesignation,L2CacheSize `
       | Out-File -filepath $strOutputFile -append

echo "******* BIOS"  >> $strOutputFile
get-WmiObject Win32_BIOS -computername $strComputerName -ErrorAction SilentlyContinue `
       | Out-File -filepath $strOutputFile -append

echo "******* Base Board"  >> $strOutputFile
get-WmiObject Win32_BaseBoard -computername $strComputerName -ErrorAction SilentlyContinue `
       | Out-File -filepath $strOutputFile -append

echo "******* Operating System"  >> $strOutputFile
$strWMIquery = "select * from Win32_OperatingSystem where Primary = True"
get-WmiObject -query $strWMIquery -computername $strComputerName -ErrorAction SilentlyContinue `
       | format-List -property Name,Version,CSDVersion,SerialNumber,Locale,InstallDate,LastBootUpTime,TotalVisibleMemorySize `
       | Out-File -filepath $strOutputFile -append

echo "******* Logical Disks"  >> $strOutputFile
$strWMIquery = "select * from Win32_LogicalDisk where DriveType = 3"
get-wmiobject -query $strWMIquery -computername $strComputerName -ErrorAction SilentlyContinue `
       | format-List -property DeviceID,VolumeName,FileSystem,Size,FreeSpace,VolumeSerialNumber `
       | Out-File -filepath $strOutputFile -append

echo "******* Video Controller"  >> $strOutputFile
get-wmiobject Win32_VideoController -computername $strComputerName -ErrorAction SilentlyContinue `
       | format-List -property Name,DriverVersion,DriverDate,PNPDeviceID `
       | Out-File -filepath $strOutputFile -append

echo "******* Network Configuration"  >> $strOutputFile
$strWMIquery = "select * from Win32_NetworkAdapterConfiguration where IPenabled = True"
get-WmiObject -query $strWMIquery -computername $strComputerName -ErrorAction SilentlyContinue `
       | format-List -property Description,IPAddress,IPSubnet,DefaultIPGateway,DNSServerSearchOrder,MACAddress `
       | Out-File -filepath $strOutputFile -append

echo "******* Shares"  >> $strOutputFile
get-WmiObject Win32_Share -computername $strComputerName -ErrorAction SilentlyContinue `
       | Out-File -filepath $strOutputFile -append

echo "******* Applications (Windows Installer based)"  >> $strOutputFile
get-WmiObject Win32_Product -computername $strComputerName -ErrorAction SilentlyContinue `
       | format-List -property Name,Vendor,Version,InstallDate,InstallState,URLInfoAbout `
       | Out-File -filepath $strOutputFile -append

echo "DONE."
