$OUPath = " " 
# example:DC=FABRIKAM,DC=COM
$Name = " "
$Surname = " "
$GivenName = " "
$SamAccountName = " "
$Path = " "
$GName = " "
$GCategory = " "
$GScope = " "
$GDisplayName = " "
$GPath = " "
$GDescription = " "
$GFolder = " "
$GMemberOfFolder = " "
New-ADOrganizationalUnit -Name "UserAccounts" -Path $OUPath


# users 

New-ADUser -Name $Name -GivenName $GivenName -Surname $Surname -SamAccountName $SamAccountName -Path $Path -AccountPassword (ConvertTo-SecureString "P@ssw0rd" -AsPlainText -Force) -Enabled $true

$HomeFolderPath = "\\fileserver\Users\$SamAccountName"
New-Item -ItemType Directory -Path $HomeFolderPath


$Acl = Get-Acl $HomeFolderPath
$Rule = New-Object System.Security.AccessControl.FileSystemAccessRule("intranet\$SamAccountName", "Modify", "Allow")
$Acl.SetAccessRule($Rule)
Set-Acl -Path $HomeFolderPath -AclObject $Acl

# groups
New-ADGroup -Name $GName -GroupCategory $GCategory -GroupScope $GScope -DisplayName $GDisplayName -Path $GPath -Description $GDescription


# nesting
Add-ADGroupMember -Identity $GFolder -Members $GMemberOfFolder