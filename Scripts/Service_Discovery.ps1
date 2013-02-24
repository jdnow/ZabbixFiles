# Powershell script to fetch a list of autostarted services via WMI and report back in a JSON
# formatted message that Zabbix will understand for Low Level Discovery purposes.
#


param(
	[Parameter(Mandatory=$False)]
	[string]$QueryName
)

$QueryName = 'None'

# First, fetch the list of auto started services
if ($QueryName -eq 'None')
	{$colItems = Get-WmiObject Win32_Service | where-object { $_.StartMode -eq 'Auto' }}
else
	{$colItems = Get-WmiObject Win32_Service | where-object { $_.StartMode -eq 'Auto' -and $_.Name -eq $QueryName }}
 
	
# Output the JSON header
write-host "{"
write-host " `"data`":["
write-host

# For each object in the list of services, print the output of the JSON message with the object properties that we are interessted in
foreach ($objItem in $colItems) {
 $line =  " { `"{#SERVICESTATE}`":`"" + $objItem.State + "`" , `"{#SERVICEDISPLAY}`":`"" + $objItem.DisplayName + "`" , `"{#SERVICENAME}`":`"" + $objItem.Name + "`" , `"{#SERVICEDESC}`":`"" + $objItem.Description + "`" },"
 write-host $line
}

# Close the JSON message
write-host
write-host " ]"
write-host "}"
write-host