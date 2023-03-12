$databasePath = ""
$DomainMode = " "
$DomainName = " "
$DomainNetbiosName = " "
$ForestMode = " "
$LogPath = " "

Add-WindowsFeature AD-Domain-Services

Install-ADDSForest -CreateDnsDelegation:$false -DatabasePath $databasePath -DomainMode $DomainMode -DomainName $DomainName -DomainNetbiosName $DomainNetbiosName -ForestMode $ForestMode -InstallDns:$true -LogPath $LogPath -NoRebootOnCompletion:$true -SysvolPath 'C:\Windows\SYSVOL' -Force:$true

Restart-Computer -Force -ErrorAction Stop