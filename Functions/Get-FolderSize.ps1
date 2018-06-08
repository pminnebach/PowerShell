function Get-FolderSize
{
    [CmdletBinding()]
    Param
    (
        [validateset("Name","Size","Files","Folders")]
        [string]$Sort = "Size",

        [switch]$Descending
    )

    $table = @()
    foreach ($folder in (Get-ChildItem -Directory))
    {
        $sum = Get-ChildItem $folder -Recurse | Measure-Object -Property length -Sum -ErrorAction SilentlyContinue
        $folders = (Get-ChildItem -Path $folder -Recurse -Directory | Measure-Object).Count
        $size = $sum.sum
        $table += [pscustomobject]@{
                                        "Name" = $folder.Name 
                                        "Size" = $size/1GB
                                        "Files" = $sum.Count
                                        "Folders" = $folders
                                   }
    }

    $splat = @{}

    if ($Sort -eq "Size")
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

    $table | 
        Sort-Object $($sort) @splat | 
            Format-Table Name,  Files, Folders, @{n="Size (GB)"; e={$_.size}; f="{0:N2}"; a='Right'} -AutoSize
}
# SIG # Begin signature block
# MIID6QYJKoZIhvcNAQcCoIID2jCCA9YCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUzKE4U2lFML2Zv/JvZOd8abWC
# GZCgggIKMIICBjCCAXOgAwIBAgIQS1udnvooNrBMW4Ea46dICzAJBgUrDgMCHQUA
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
# AYI3AgEVMCMGCSqGSIb3DQEJBDEWBBTlwQ9v7vAHhgW6wnkyEX5Qp4c+6TANBgkq
# hkiG9w0BAQEFAASBgGmppVijW2L4AL7ol2Vu9aHUazA4A3D+2S0iZ77B2yOJdS2G
# IKTl8RG9HbYw11btwLvLOeEZkdIf0DjxvuJWvScUoVeVXtSPT8yIrdZSg3wtjRL+
# QIr7g5cCubqDfnp+ATLLc6y5d60rwqO+NVcGk62ayoxNXFb3MHCak7gtfAo6
# SIG # End signature block
