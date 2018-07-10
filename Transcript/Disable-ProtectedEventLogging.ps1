function Disable-ProtectedEventLogging
{
    Remove-Item HKLM:\Software\Policies\Microsoft\Windows\EventLog\ProtectedEventLogging -Force –Recurse
}
