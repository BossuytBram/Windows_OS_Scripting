$Path = "\\win01\CompanyInfo"
$FolderPath = $Path + "\recipes"
remove-DfsnRoot -Path $Path
# must manually confirm operations

# remove folder
Remove-DfsnFolder -Path $FolderPath -Force
