$UPN = "@abc.com"

Get-ADForest | Set-ADForest -UPNSuffixes @{add = $UPN }