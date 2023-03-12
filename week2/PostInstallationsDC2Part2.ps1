$Dnsserver = ""
$DnsserverAlternate = ""
$StartRange = ""
$EndRange = ""
$Subnetmask = ""
$ScopeId = ""
$EStartrang = ""
$EEndrange = ""
$IpDhcp = 
$Name = ""
$PName = ""
$ScopeId2 = ""
Set-DnsClientServerAddress -ServerAddresses ($Dnsserver, $DnsserverAlternate)

Install-WindowsFeature DHCP -IncludeManagementTools 

Add-DhcpServerv4Scope -name "Dhcprange" -StartRange $StartRange -EndRange $EndRange -SubnetMask $Subnetmask -State Active
Add-DhcpServerv4ExclusionRange -ScopeID $ScopeId2 -StartRange $EStartrang -EndRange $EEndrange
Set-DhcpServerv4OptionValue -OptionID 3 -Value $IpDhcp -ScopeID $ScopeId2
Set-DhcpServerv4OptionValue -OptionID 4 -Value $Dnsserver -ScopeID $ScopeId2

Add-DhcpServerv4Failover -ComputerName $Name -Name "Failover" -PartnerServer $PName -ScopeId ($ScopeId, $ScopeId2)-LoadBalancePercent 60 -MaxClientLeadTime 2:00:00 -AutoStateTransition $True -StateSwitchInterval 2:00:00