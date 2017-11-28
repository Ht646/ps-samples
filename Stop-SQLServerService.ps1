## =====================================================================
## Title       : Stop-SQLServerService
## Description : Stop SQL Server service for default instance

 
param
(
	[string]$service = "MSSQLServer",
	[switch]$verbose,
	[switch]$debug
)

function main()
{
	if ($verbose) {$VerbosePreference = "Continue"}
	if ($debug) {$DebugPreference = "Continue"}
	Stop-SQLServerService $service
}

function Stop-SQLServerService()
{
	Stop-Service $service -Force
	Write-Host "$service service stopped"
}

main