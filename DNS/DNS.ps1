<#
.SYNOPSIS
.This script does require DNS Modules.
Author: Venkata Krishnaji A
    
.DESCRIPTION
This script is designed to help during Migrate DNS Records from One Local DNS Server to Another:
....1.	Exporting DNS records from the old (source) DNS server.
....2.	Importing DNS records into the new (destination) DNS server.
....3.	Testing and verifying that the records are functioning as expected.
....4.	Switching over the DNS settings for clients and servers.

/DNS-migration-project
│
├── README.md        # Project overview and instructions
├── Define-dns       # Define DNS Servers
├── Export-dns       # Export DNS Records from Old DNS Server
├── Import-dns       # Import DNS Records into New DNS Server
├── Verify-dns       # Verify DNS Resolution
├── LICENSE          # License for the project
└── .gitignore       # Ignore unnecessary files (e.g., backup files)

#>

#///////Accept the input information for the script


# Define DNS Servers
$oldDnsServer = "OldDnsServer"
$newDnsServer = "NewDnsServer"
$zoneName = "yourdomain.local"
$csvFilePath = "C:\Backup\DNS_Records.csv"

# Step 1: Export DNS Records from Old DNS Server
$dnsRecords = Get-DnsServerResourceRecord -ComputerName $oldDnsServer -ZoneName $zoneName
$dnsRecords | Export-Csv $csvFilePath -NoTypeInformation

# Step 2: Import DNS Records into New DNS Server
$records = Import-Csv $csvFilePath
foreach ($record in $records) {
    # Assuming you are dealing with A records; modify for other types as needed
    Add-DnsServerResourceRecordA -ComputerName $newDnsServer -Name $record.Name -IPv4Address $record.RecordData -ZoneName $zoneName
}

# Step 3: Verify DNS Resolution
$resolved = Resolve-DnsName -Name "hostname.yourdomain.local" -Server $newDnsServer
Write-Host "DNS Resolution: $($resolved.IPAddress)"

# Optional: Set New DNS Server on Domain Controllers and Clients
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses ("NewDnsServerIP")
