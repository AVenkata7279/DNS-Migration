# Steps to Migrate DNS Records from One Local DNS Server to Another

This repository contains scripts and instructions for migrating the DNS records within a local network

## When you're migrating DNS records within a local network, the process generally involves:

1.	Exporting DNS records from the old (source) DNS server.
2.	Importing DNS records into the new (destination) DNS server.
3.	Testing and verifying that the records are functioning as expected.
4.	Switching over the DNS settings for clients and servers.

## Steps for Migration

1.	Exporting DNS records from the old (source) DNS server.
    You can use PowerShell to export the DNS records from the old DNS server (which could be a Windows DNS server) to a file.
2.	Importing DNS records into the new (destination) DNS server.
    Once you've exported the DNS records, the next step is to import them into the new DNS server.
    For this, you can write a PowerShell script that reads the CSV file and adds the records to the new DNS server.
3.	Testing and verifying that the records are functioning as expected.
    After importing the records into the new DNS server, you should verify that they are functioning correctly.
    Verifying DNS Records
    Use the Resolve-DnsName cmdlet to check whether the DNS records are resolving correctly from the new server:

4.  Update DNS Settings on Domain Controllers and Clients
    Once you've confirmed the DNS records are correct on the new DNS server:
•	Update the domain controllers and client machines to point to the new DNS server.
•	If you're using Active Directory-integrated zones, ensure that DNS replication is properly set up.



## Prerequisites

- Windows Server version [Specify Version]
- Administrative access to both DNS servers
- PowerShell 5.0 or higher