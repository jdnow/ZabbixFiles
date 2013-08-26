param(
	[Parameter(Mandatory=$False)]
	[string]$QueryName,
    [string]$FSName
)

if ($QueryName -eq '') {
    
    $colItems = gwmi win32_volume | select Name,FileSystem

    write-host "{"
    write-host " `"data`":["
    write-host

    foreach ($objItem in $colItems) {
        $objItem.Name = $objItem.Name -replace "\\\\\?\\Volume{","Volume-"
        $objItem.Name = $objItem.Name -replace "}\\","`+"
        $objItem.Name = $objItem.Name -replace "\\","/"
        $line =  " { `"{#FSNAME}`":`"" + $objItem.Name + "`" , `"{#FSTYPE}`":`"" + $objItem.FileSystem + "`" },"
        write-host $line
    }

    write-host
    write-host " ]"
    write-host "}"
    write-host
}

else {
    #$FSName = [regex]::escape($FSName)
    $FSName = $FSName -replace "Volume-","\\\\?\\Volume{"
    $FSName = $FSName -replace "\+","}\\"
    $FSName = $FSName -replace "/","\\"
    switch ($QueryName)
        {
        ('Capacity') {$Results = gwmi win32_volume -Filter "name = '$FSName'" | select Capacity | Format-Table -HideTableHeaders -AutoSize}
        ('FreeSpace') {$Results = gwmi win32_volume -Filter "name = '$FSName'" | select FreeSpace | Format-Table -HideTableHeaders -AutoSize}
        default {$Results = "Incorrect Command Given"}
        }
    $Results = $Results | Out-String
    $Results = $Results.trim()
    Write-Host $Results

}