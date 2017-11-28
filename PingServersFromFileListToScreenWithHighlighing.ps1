$DMZserver = Get-Content C:\temp\pingedservers.txt

Foreach ($computer in $DMZserver) {

		$testingConnection = Test-Connection -ComputerName $DMZserver -Count 1 -Quiet
        }		
		if ($testingConnection -eq 'True')  {
				Write-Host "$computer is online" -ForegroundColor Green
				
		}
		
		else {
		
		Write-Host "$server is OFFLINE!" -ForegroundColor red -BackgroundColor Yellow
		
		}