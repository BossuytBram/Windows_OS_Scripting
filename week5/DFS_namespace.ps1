# Create the new domain DFS name space
New-DfsnRoot -TargetPath "\\win01-dc1\CompanyInfo" -Type DomainV2 -Path "\\win01\CompanyInfo"

New-DfsnFolder -Path "\\win01\CompanyInfo\recipes" -TargetPath "\\win01-ms\recipes" -EnableTargetFailback $True -Description "Folder for  recipes."
New-DfsnFolder -Path "\\win01\CompanyInfo\menus" -TargetPath "\\win01-dc2\menus" -EnableTargetFailback $True -Description "Folder for  menus."
