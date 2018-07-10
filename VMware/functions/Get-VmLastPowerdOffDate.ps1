<#
.Synopsis
   Get the date the VM was last powered off.
.DESCRIPTION
   The Get-VmLastPowerdOffDate function retrieves the date the VM was last powered off.

   Based on this thread: https://communities.vmware.com/thread/540397
.EXAMPLE
   Get-VmLastPowerdOffDate -Name playground
   Saturday, 9 September 2017 15:13:52
.NOTES
   This function does not check if you are connected to a ViServer. 
   This function does not check if the VM is actualy powered of.

   By default, events are only saved for 30 days in the VCSA database. So when the VM 
   has been shutdown more than 30 days ago, the Date will be $null.
#>
function Get-VmLastPowerdOffDate
{
    [CmdletBinding(SupportsShouldProcess=$true)]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true)]
        [string]
        $Name
    )

    Begin
    {
    }
    Process
    {        
        if ($pscmdlet.ShouldProcess($Name, "Retrieving the date the VM was powered off for ")) 
        {
            [pscustomobject]@{
                Name = $Name
                Date = (Get-VM -Name $Name | 
                    Get-VIEvent -MaxSamples ([int]::MaxValue) |
                        Where-Object { $_ -is [VMware.Vim.VmPoweredOffEvent] } | 
                            Group-Object -Property Vm.Name |
                                ForEach-Object {
                                    $_.Group.CreatedTime | Sort-Object -Descending | Select-Object -First 1
                                }
                )
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
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUbavdmT5yZviFLV6ZVdGLWSWY
# i6egggIKMIICBjCCAXOgAwIBAgIQS1udnvooNrBMW4Ea46dICzAJBgUrDgMCHQUA
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
# AYI3AgEVMCMGCSqGSIb3DQEJBDEWBBRIj9c3xcsDHLuyUNDn9gXHoliUZDANBgkq
# hkiG9w0BAQEFAASBgIsd8gMYMBHQG+u1mUzYdSn5J2WowuKtgHXEuucInKIqvE5e
# Qvb3DP/P6vc9zsYLFFA8b7WFBWERKEzNdws/9j4wZFvFPwIm4eVMWRFoLCorYiPt
# DB+bDz7rFHWGLJRHCAqCG/NYh9IrjCukJ/HyLVUYka6ghALPf4SpzDbQKFCD
# SIG # End signature block
