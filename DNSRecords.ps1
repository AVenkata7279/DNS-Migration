<#
.SYNOPSIS
.This script does require DNS Modules.
Author: Venkata Krishnaji A
    
.DESCRIPTION
This script is designed to help to get IP's from DNS server:

│
├── README.md                       # Project overview and instructions
├── Get-DnsServerResourceRecord     # Get all DNS record names
├── Zone Nmae                       # Get Zones in DNS
├── LICENSE                         # License for the project
└── .gitignore                      # Ignore unnecessary files (e.g., backup files)

#>

#///////Accept the input information for the script

import-module DNSServer
$DNSReport = 
foreach($record in Get-DnsServerZone){
    $DNSInfo = Get-DnsServerResourceRecord $record.zoneName
    
    foreach($info in $DNSInfo){
        [pscustomobject]@{
            ZoneName   = $record.zoneName
            HostName   = $info.hostname
            TimeStamp  = $info.timestamp
            RecordType = $info.recordtype
            RecordData = if($info.RecordData.IPv4Address){
                             $info.RecordData.IPv4Address.IPAddressToString}
                         else{
                             try{$info.RecordData.NameServer.ToUpper()}catch{}
                         }
        }
    }
}

$DNSReport |
Export-Csv "DNSRecords.csv" -NoTypeInformation
