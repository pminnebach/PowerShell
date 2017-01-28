[CmdletBinding()]
Param
(
    [Parameter(Mandatory=$true)]
    [string]$ModuleName,

    # Provide your own path instead of the default.
    # Disabled for now untill
    # [string]$Path,
    
    [Parameter(Mandatory=$true)]
    [AllowNull()]
    [AllowEmptyString()]
    [string]$AuthorName,
    
    [Parameter(Mandatory=$true)]
    [AllowNull()]
    [AllowEmptyString()]
    [string]$CompanyName,
    
    [Parameter(Mandatory=$true)]
    [AllowNull()]
    [AllowEmptyString()]
    [string]$Description
)

if($PSVersionTable.PSVersion.Major -gt 5)
{
    try {
        $uname = uname -a
        if ($uname -like "*Darwin*") 
        {
            Write-Verbose "Darwin detected, probably OS X (macOS for the newfags)."
            $DefaultModulePath = ($env:PSMODULEPATH).Split(':')[0]
        }
        elseif ($uname -like "*Linux*") 
        {
            Write-Verbose "Linux detected."
            $DefaultModulePath = ($env:PSMODULEPATH).Split(':')[0]
        }
        elseif ([System.Environment]::OSVersion.Platform -like "Win32NT") 
        {
            $DefaultModulePath = ($env:PSMODULEPATH).Split(';')[0]
        }
        else 
        {
            Write-Host "Could not determine OS version"
        }
        # In a future version of Posh we can use the Environment variable or $PSVersionTable to get OS info.
        # Git issue #2009
        # [System.Environment]::OSVersion
    }
    catch 
    {
        Write-Error "Could not determine OS version via uname. Asuming Windows."
    }    
}
elseif ($PSVersionTable.PSVersion.Major -le 5) 
{
    $DefaultModulePath = ($env:PSMODULEPATH).Split(';')[0]
}
else 
{
    Write-Host "Could not determine OS version"
}

Write-Verbose "Default Mdule Path: $DefaultModulePath"

# Set the path to create based on either the provided path or the default PSModulePath.
if (!$Path)
{ 
    $PathToCreate = "${DefaultModulePath}\${ModuleName}" 
}
else
{ 
    $Path = $Path.TrimEnd('/')
    $PathToCreate = "${Path}\${ModuleName}"
}

# Create the actual folder which is gonna contain the powershell scripts.
New-Item -ItemType directory -Path $PathToCreate | Out-Null

# Test if the path is actualty created
if (Test-Path $PathToCreate)
    { Write-Verbose "Created: $PathToCreate" }
else
    { Write-Error "Creation of folder went wrong" }

# Create an empty .psm1 file which can be filled with your custom functions
New-Item -ItemType file -Path "${PathToCreate}\${ModuleName}.psm1" | Out-Null


$Module = get-module -ListAvailable -Name $ModuleName
#$Module | select *

$CreatedModulePath = $Module.ModuleBase
Write-Verbose "ModuleBase: $CreatedModulePath"

$params = @{
    'Author' = $AuthorName
    'CompanyName' = $CompanyName
    'Description' = $Description
    'NestedModules' = $ModuleName
    'Path' = "${CreatedModulePath}\${ModuleName}.psd1"
}

# Create the module manifest
New-ModuleManifest @params

# List all information from the module manifest.
$Module = get-module -ListAvailable -Name $ModuleName
$Module | Select-Object *

Write-Verbose "Module folder and samples created." -Verbose
