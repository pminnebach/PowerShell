function Disable-PSScriptBlockLogging
{
    Remove-Item HKLM:\Software\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging -Force -Recurse
}
