$staticIPaddr = " "
$defaultgateway = " "
$prefixlength = " "
$dnsserver1 = " "
$dnsserver2 = " "

Function SetControlPanelSmallIcons {
    try {   
        If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel")) {
            New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel" | Out-Null
        }
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel" -Name "StartupPage" -Type DWord -Value 1
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel" -Name "AllItemsIconView" -Type DWord -Value 1
    }
    catch {
        <#Do this if a terminating exception happens#>
        Write-Error "something went wrong during small icons"
        exit 1
    }

}

Function ShowFileExtensions {
    try {      
        #to show file extensions
        Push-Location
        Set-Location HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced
        Set-ItemProperty . HideFileExt "0"
        Pop-Location
    }
    catch {
        <#Do this if a terminating exception happens#>
        Write-Error "something went wrong during show file extensions"
        exit 1
    }

}
Function restart {

    #restart computer
    Restart-Computer -Force -ErrorAction Stop
}

Function DisableIEEnhancedSecurity {
    try {
        # Disable IE Enhanced Security Setting for both admins and users
        $AdminKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}"
        $UserKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}"
        Set-ItemProperty -Path $AdminKey -Name "IsInstalled" -Value 0 -Force
        Set-ItemProperty -Path $UserKey -Name "IsInstalled" -Value 0 -Force
        Stop-Process -Name Explorer -Force
    }
    catch {
        <#Do this if a terminating exception happens#>
        Write-Error "something went wrong during DisableIEEnhancedSecurity"
        exit 1
    }
    
}

Function EnableRempteDesktopAccess {
    try {
        # enables remote desktop access
        Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value 0
    }
    catch {
        <#Do this if a terminating exception happens#>
        Write-Error "something went wrong during EnableRempteDesktopAccess"
        exit 1
    }
    
}
Function SetTimezoneToCET {
    try {
        #changes timezone to CET
        Set-TimeZone -Id "CET"
    }
    catch {
        <#Do this if a terminating exception happens#>
        Write-Error "something went wrong during SetTimezoneToCET "
        exit 1
    }
    
}
Function ChangeHostname {
    try {
        #renames the hostname
        Rename-Computer -NewName "DC01"
    }
    catch {
        <#Do this if a terminating exception happens#>
        Write-Error "something went wrong during ChangeHostname "
    }
}
Function SetStaticIP {
    try {
        #changing the static ip
        Push-Location C:\Windows\System32
        New-NetIPAddress –IPAddress $staticIPaddr -DefaultGateway $defaultgateway -PrefixLength $prefixlength -InterfaceIndex (Get-NetAdapter).InterfaceIndex
        Set-DNSClientServerAddress –InterfaceIndex (Get-NetAdapter).InterfaceIndex –ServerAddresses $dnsserver1, $dnsserver2
        Pop-Location
    }
    catch {
        <#Do this if a terminating exception happens#>
        Write-Error "something went wrong during SetStaticIP "
    }
    
}

SetStaticIP
Start-Sleep -Seconds 1.5
SetTimezoneToCET
Start-Sleep -Seconds 1.5
EnableRempteDesktopAccess
Start-Sleep -Seconds 1.5
DisableIEEnhancedSecurity
Start-Sleep -Seconds 1.5
SetControlPanelSmallIcons
Start-Sleep -Seconds 1.5
ShowFileExtensions
Start-Sleep -Seconds 1.5
ChangeHostname
restart