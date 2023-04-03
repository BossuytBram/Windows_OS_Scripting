

# homefolders

New-SmbShare -Name "Home" -Path "C:\Home" -FullAccess "Everyone"

$ACL = Get-Acl -Path "\\localhost\Home"
$ACL.SetAccessRuleProtection($true, $false)


$Rule = New-Object System.Security.AccessControl.FileSystemAccessRule("Domain Users", "ReadAndExecute", "Allow")
$ACL.SetAccessRule($Rule)

Set-Acl -Path "\\localhost\Home" -AclObject $ACL

# datafolders


$ShareName = "DataShare"
$SharePath = "D:\DataShare"

New-Item -ItemType Directory -Path $SharePath


New-SmbShare -Name $ShareName -Path $SharePath -FullAccess "Everyone" 


$Acl = Get-Acl $SharePath
$Rule1 = New-Object System.Security.AccessControl.FileSystemAccessRule("Domain Admins", "FullControl", "Allow")
$Rule2 = New-Object System.Security.AccessControl.FileSystemAccessRule("Domain Users", "ReadAndExecute", "Allow")
$Acl.SetAccessRuleProtection($true, $false)
$Acl.SetAccessRule($Rule1)
$Acl.SetAccessRule($Rule2)
Set-Acl -Path $SharePath -AclObject $Acl

$Folders = @("Finance", "Marketing", "HR", "Projects", "Engineering", "Manufacturing")
foreach ($Folder in $Folders) {
    $FolderPath = "$SharePath\$Folder"
    New-Item -ItemType Directory -Path $FolderPath

    # Set folder permissions
    $AclF = Get-Acl $FolderPath
    $RuleF1 = New-Object System.Security.AccessControl.FileSystemAccessRule("Domain Admins", "FullControl", "Allow")
    $RuleF2 = New-Object System.Security.AccessControl.FileSystemAccessRule("$Folder", "Modify", "Allow")
    $RuleF3 = New-Object System.Security.AccessControl.FileSystemAccessRule("Domain Users", "ReadAndExecute", "Allow")
    $AclF.SetAccessRuleProtection($true, $false)
    $AclF.SetAccessRule($RuleF1)
    $AclF.SetAccessRule($RuleF2)
    $AclF.SetAccessRule($RuleF3)
    Set-Acl -Path $FolderPath -AclObject $AclF
}