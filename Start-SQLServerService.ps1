## =====================================================================
## Title       : Start-SQLServerService
## Description : Start SQL Server service for default instance

 
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
	Start-SQLServerService $service
}

function Start-SQLServerService()
{
	Start-Service $service
	Write-Host "$service service started"
}

main