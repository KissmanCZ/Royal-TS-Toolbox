Import-Module ActiveDirectory
[System.Collections.ArrayList]$array = @()
foreach ($computer in Get-ADComputer -Filter {PrimaryGroupID -eq 521})
{
    $array.add((
            New-Object -TypeName System.Management.Automation.PSObject -Property @{
                "Type" = "RemoteDesktopConnection";
                "Name" = $computer.Name;
                "ComputerName" = $computer.DNSHostName;
            }
        )) | Out-Null
}
$array = $array | Sort-Object -Property name
$hash = @{}
$null = $hash.Add("Objects", $array)
$hash | ConvertTo-Json
