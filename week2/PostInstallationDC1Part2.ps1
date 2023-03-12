$Dnsserver = ""
$DnsserverAlternate = ""
$NetworkDns = " "
$StartRange = ""
$EndRange = ""
$Subnetmask = ""
$ScopeId = ""
$EStartrang = ""
$EEndrange = ""
$IpDhcp = " "

Set-DnsClientServerAddress -ServerAddresses ($Dnsserver, $DnsserverAlternate)

Add-DnsServerPrimaryZone -NetworkID $NetworkDns -ReplicationScope "Forest"


Install-WindowsFeature DHCP -IncludeManagementTools 

Add-DhcpServerv4Scope -name "Dhcprange" -StartRange $StartRange -EndRange $EndRange -SubnetMask $Subnetmask -State Active
Add-DhcpServerv4ExclusionRange -ScopeID $ScopeId -StartRange $EStartrang -EndRange $EEndrange
Set-DhcpServerv4OptionValue -OptionID 3 -Value $IpDhcp -ScopeID $ScopeId
Set-DhcpServerv4OptionValue -OptionID 4 -Value $Dnsserver -ScopeID $ScopeId