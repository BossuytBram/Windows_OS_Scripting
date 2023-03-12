$databasePath = ""
$DomainName = " "
$LogPath = " "
$Sitename = ""

Add-WindowsFeature AD-Domain-Services

Install-ADDSDomainController -CreateDnsDelegation:$false -DatabasePath $databasePath -DomainName $DomainName -InstallDns:$true -LogPath $LogPath -NoGlobalCatalog:$false -SiteName $Sitename -SysvolPath 'C:\Windows\SYSVOL' -NoRebootOnCompletion:$true -Force:$true

Restart-Computer -Force -ErrorAction Stop