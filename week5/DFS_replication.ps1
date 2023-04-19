
New-DfsReplicationGroup -GroupName "AllMenus'" | New-DfsReplicatedFolder -FolderName "AllMenusFolder" | Add-DfsrMember -ComputerName "win01-dc2", "win01-ms" | Format-Table dnsname, groupname -auto -wrap

Add-DfsrConnection -GroupName "AllMenus" -SourceComputerName "win01-dc1" -DestinationComputerName "win01-dc2" | Format-Table *name -wrap -autosize


Add-DfsrConnection -GroupName "AllMenus" -SourceComputerName "win01-dc1" -DestinationComputerName "win01-ms" | Format-Table *name -wrap -autosize


Set-DfsrMembership -GroupName "ALlMenus" -FolderName "ALlMenusFolder" -ContentPath "\\win01-dc2\menus" -ComputerName "win01-dc1" -PrimaryMember $True -StagingPathQuotaInMB 16384 -Force | Format-Table *name, *path, primary* -autosize -wrap

Set-DfsrMembership -GroupName "AllMenus" -FolderName "AllMenusFolder" -ContentPath "\\win01-dc2\menus" -ComputerName "win01-dc2", "win01-ms" -StagingPathQuotaInMB 16384 -Force | Format-Table *name, *path, primary* -autosize -wrap
