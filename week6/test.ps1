$addrs = ""
$Name = ""
$secret = ""
$rmvName = ""
$ELink = ""
$ILink = ""
# 1
Install-WindowsFeature NPAS -IncludeManagementTools
# Install-AdcsCertificationAuthority -CAType EnterpriseRootCA
# 2

# 3

# 4.1
foreach (client in collection) {
    
    New-NpsRadiusClient -Address $addrs -Name $Name -SharedSecret $secret
}
# 4.2
Remove-NpsRadiusClient -Name $rmvName
# 5
Export-NpsConfiguration -Path $ELink
Import-NpsConfiguration -Path $ILink
# 6
