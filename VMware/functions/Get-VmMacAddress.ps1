<#
.Synopsis
   Get mac addresses from VMware esxi vm's.
.DESCRIPTION
   Get mac addresses from VMware esxi vm's.

   The formatting is with dashes instead of colons, so it can be consumed in the Add-DhcpServerv4Reservation cmdlet.
.EXAMPLE
   Get-MacFromVm -Name DC001

   Name   ClientId              
   ----   ---              
   DC001  00-0c-29-97-33-c1
.EXAMPLE
   Get-MacFromVm -Name DC001, plex, vcsa01

   Name   ClientId              
   ----   ---              
   DC001  00-0c-29-97-33-c1
   plex   00-0c-29-6c-c5-e5
   vcsa01 00-0c-29-20-a1-25
.EXAMPLE
   Get-VM | Get-MacFromVm

   Name     ClientId         
   ----     --------         
   FS01     00-50-56-a6-00-93
   upspin01 00-50-56-a6-1b-24
   veeam01  00-50-56-a6-2e-c2
.EXAMPLE
   "plex", "DC001", "plex01" | Get-MacFromVm
    Name   ClientId         
    ----   --------         
    plex   00-0c-29-6c-c5-e5
    DC001  00-0c-29-97-33-c1
    plex01 00-50-56-a6-a6-3a
.INPUTS
    An array of names.
.OUTPUTS
    Tha VmNames and their mac address (ClientId).
#>
function Get-VmMacAddress
{
    [CmdletBinding(SupportsShouldProcess=$true)]
    Param
    (
        # The name of the VM of which we want to obtain the mac address.
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true)]
        [string[]]
        $Name
    )

    Begin
    {
    }
    Process
    {        
        foreach ($item in $Name)
        {
            if ($pscmdlet.ShouldProcess($item, "Getting the mac address")) 
            {
                Get-VM $item -PipelineVariable vm | 
                    Get-NetworkAdapter | 
                        Select-Object @{ n="Name"; e={ $vm.Name }}, @{ n="ClientId"; e={ $_.MacAddress -replace ":","-" }}
            }
        }  
    }
    End
    {
    }
}
# SIG # Begin signature block
# MIID6QYJKoZIhvcNAQcCoIID2jCCA9YCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUI2RHGPyAzBdZKdnD24JijTss
# lzqgggIKMIICBjCCAXOgAwIBAgIQS1udnvooNrBMW4Ea46dICzAJBgUrDgMCHQUA
# MBUxEzARBgNVBAMTClBoaWxpcCBMQ1IwHhcNMTcxMTA4MTEzMTE0WhcNMzkxMjMx
# MjM1OTU5WjAVMRMwEQYDVQQDEwpQaGlsaXAgQ1NDMIGfMA0GCSqGSIb3DQEBAQUA
# A4GNADCBiQKBgQCk4Pl37NORv5CKPIKp0sZ8p5u/vun01Jyku8XHhhhOrugvD0x6
# R0i6qxK0r98RJ8nINP7rBfpyi/qQruzjAtIwMOYpnswLHP0CVO93oikvBwefHWXj
# DaT4IAgVnXMQcyjYRKsvCV+7HhLlfJugp/sl8JAv1Xea+4Z6GYmw+3dDBQIDAQAB
# o18wXTATBgNVHSUEDDAKBggrBgEFBQcDAzBGBgNVHQEEPzA9gBAhTlKezGMDc+oH
# gUWmLFaWoRcwFTETMBEGA1UEAxMKUGhpbGlwIExDUoIQ6XLzMCzjbpFAJINVZQGJ
# 2zAJBgUrDgMCHQUAA4GBAFI8QcLt3M8DuBbrPbPJoMvt2gpdMmlTC8WWSpKxq3S6
# biufvXWBqCYpQ2TxXVmn1vp9gqc1PqQxmezkBqJwF/kTaJxDVSPdf/c7Phj+cjG5
# 5CGqe0y8Z41G8H58gHP/oOaLEmMBv4a51cvapQe4dHu5BNIWPGzC93E6Nsxo+rn3
# MYIBSTCCAUUCAQEwKTAVMRMwEQYDVQQDEwpQaGlsaXAgTENSAhBLW52e+ig2sExb
# gRrjp0gLMAkGBSsOAwIaBQCgeDAYBgorBgEEAYI3AgEMMQowCKACgAChAoAAMBkG
# CSqGSIb3DQEJAzEMBgorBgEEAYI3AgEEMBwGCisGAQQBgjcCAQsxDjAMBgorBgEE
# AYI3AgEVMCMGCSqGSIb3DQEJBDEWBBTUBhYTFJ7tE6mFNSoIqAoDyPS2WDANBgkq
# hkiG9w0BAQEFAASBgGGYYNKQTFxyegYeSFpXZ1jnK3FBBkB/PiC3Sy6qyEnCSCEW
# +LtPDjZdStZyzKO01oWbeOz/+FWqWB90P6CHgYEBTGhaEjBQRqmIFcFnw+8Fgc6j
# RIjaxxx/WRAacuyNWk+7NHwKPCAx8NwZcFOtH5tol8dS66hVOYH260r5yn6M
# SIG # End signature block
