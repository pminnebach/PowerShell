[CmdletBinding()]
Param
(
    [Parameter(Mandatory=$true)]
    [string]$ModuleName,

    [string]$NewModulePath,
    
    [Parameter(Mandatory=$true)]
    [string]$AuthorName,
    
    [Parameter(Mandatory=$true)]
    [string]$CompanyName,
    
    [Parameter(Mandatory=$true)]
    [string]$Description
)

$DefaultModulePath = ($env:PSModulePath).Split(';')[0]

# Set the path to create based on either the provided path or the default PSModulePath.
if (!$NewModulePath)
    { $PathToCreate = "${DefaultModulePath}\${ModuleName}" }
else 
    { $PathToCreate = $NewModulePath }

# Create the actual folder which is gonna contain the powershell scripts.
New-Item -ItemType directory -Path $PathToCreate

# Test if the path is actualty created
if (Test-Path $PathToCreate)
    {Write-Verbose "Created: $PathToCreate"}
else
    {Write-Error "Creation of path went wrong"}

# Create an empty .psm1 file which can be filled with your custom functions
New-Item -ItemType file -Path "${PathToCreate}\${ModuleName}.psm1"


$Module = get-module -ListAvailable -Name $ModuleName
#$Module | select *

$CreatedModulePath = $Module.ModuleBase
Write-Verbose $CreatedModulePath

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
$Module | select *
