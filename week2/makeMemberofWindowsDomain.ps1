$DomainName

function JoinDomain {

    Add-Computer -DomainName $DomainName -Restart
}





JoinDomain