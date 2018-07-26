# PowerShell

## Functions

## Transcript

## VMware/functions

### Get-VmLastPowerdOffDate.ps1

### Get-VmMacAddress.ps1

This function gets the mac address from a VM running on an esxi host. The output is structured so that i can easily be piped in the DHCP cmdlets from Windows Server to create static leases.

```powershell
PS C:\Users\pminnebach> Get-VM | Get-VmMacAddress

Name                         ClientId
----                         --------
VM01                         00-11-22-33-44-55
VM02                         66-77-88-99-a1-a2
VM03                         a3-a4-a5-a6-a7-a8
```
