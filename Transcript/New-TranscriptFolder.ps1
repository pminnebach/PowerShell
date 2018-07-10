$path = "S:\Shares\Transcript"

md $path

## Kill all inherited permissions
$acl = Get-Acl $path
$acl.SetAccessRuleProtection($true, $false)

## Grant Administrators full control
$administrators = [System.Security.Principal.NTAccount] “Administrators”
$permission = $administrators,“FullControl”,“ObjectInherit,ContainerInherit”,“None”,“Allow”
$accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule $permission
$acl.AddAccessRule($accessRule)

## Grant everyone else Write and ReadAttributes. This prevents users from listing
## transcripts from other machines on the domain.
$everyone = [System.Security.Principal.NTAccount] “Everyone”
$permission = $everyone,“Write,ReadAttributes”,“ObjectInherit,ContainerInherit”,“None”,“Allow”
$accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule $permission
$acl.AddAccessRule($accessRule)

## Deny “Creator Owner” everything. This prevents users from
## viewing the content of previously written files.
$creatorOwner = [System.Security.Principal.NTAccount] “Creator Owner”
$permission = $creatorOwner,“FullControl”,“ObjectInherit,ContainerInherit”,“InheritOnly”,“Deny”
$accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule $permission
$acl.AddAccessRule($accessRule)

## Set the ACL
$acl | Set-Acl $path

## Create the SMB Share, granting Everyone the right to read and write files. Specific
## actions will actually be enforced by the ACL on the file folder.
New-SmbShare -Name "Transcript$" -Path $path -ChangeAccess Everyone