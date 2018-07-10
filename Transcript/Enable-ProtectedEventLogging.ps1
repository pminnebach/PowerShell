function Enable-ProtectedEventLogging
{
    param(
        [Parameter(Mandatory)]
        $Certificate
    )

    $basePath = “HKLM:\Software\Policies\Microsoft\Windows\EventLog\ProtectedEventLogging”
    if(-not (Test-Path $basePath))
    {
        $null = New-Item $basePath –Force
    }


    Set-ItemProperty $basePath -Name EnableProtectedEventLogging -Value “1”
    Set-ItemProperty $basePath -Name EncryptionCertificate -Value $Certificate

}
