# get all installed Software from the registry
Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate

# get all installed Software from all Domain-Computers
$computer = Get-ADComputer -Filter 'enabled -eq "true"' | Select-Object -ExpandProperty Name
$result = New-Object System.Collections.ArrayList
foreach ($c in $computer) {
    $software = Invoke-Command -ComputerName $c -ScriptBlock {
        Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Where-Object {$_.DisplayName -ne $null} |
        Select-Object DisplayName
    }
    $obj = New-Object -TypeName PSObject -Property ([ordered]@{
        ComputerName = $c
        Software = $software.displayname -join "`n"
    } )
    $result.Add($obj) | Out-Null    
}
$result | Format-List | Tee-Object -FilePath $home\software_installed.txt
Start-Process $home\software_installed.txt