function Enable-PSScriptBlockInvocationLogging
{
    $basePath = “HKLM:\Software\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging”

    if(-not (Test-Path $basePath))
    {
        $null = New-Item $basePath -Force
    }

    Set-ItemProperty $basePath -Name EnableScriptBlockInvocationLogging -Value “1”
}
