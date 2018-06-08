function Get-Files
{
    [CmdletBinding()]
    Param
    (
        [validateset("Name","Length")]
        [string]$Sort = "Length",

        [switch]$Descending
    )

    $splat = @{}

    if ($Sort -eq "Length")
    {
        $splat.Add( 'Descending', $true )
    }

    if ( $Descending -eq $true ) 
    { 
        if ( !$splat.ContainsKey("Descending") )
        {
            $splat.Add( 'Descending', $true )
        }
    }

    Get-ChildItem -Recurse -File | 
        Sort-Object $($sort) @splat |
            Format-Table Name, @{ n="Size (GB)"; e={$_.Length/1GB}; a="right"; f="{0:N2}" }
}

# SIG # Begin signature block
# MIID6QYJKoZIhvcNAQcCoIID2jCCA9YCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQU1G1Q6Qu441QFfe3vepDu+zSJ
# 9jOgggIKMIICBjCCAXOgAwIBAgIQS1udnvooNrBMW4Ea46dICzAJBgUrDgMCHQUA
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
# AYI3AgEVMCMGCSqGSIb3DQEJBDEWBBTESTr+KA5d3CfdIjXdQr13trza2jANBgkq
# hkiG9w0BAQEFAASBgAMdtjzOQ8nqCIeoeD5QDJnQSPSWYcUHafrFhFlDT2zTCKkg
# z6w81qLiJMRdxuqvHIQ8DCiPwe50mbxKWnlrSuBkM18yNuk+QKZvpSTfyAYIJ1Uo
# wJU7uNG3x3ewKlahhs79voOU0k50jkp48J9xH6Y7c3hVUSZDkOT6X+tMpGfd
# SIG # End signature block
