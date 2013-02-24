# Powershell script to fetch a list of autostarted services via WMI and report back in a JSON
# formatted message that Zabbix will understand for Low Level Discovery purposes.
#

# First, fetch the list of auto started services
$colItems = Get-WmiObject Win32_Process 

# Output the JSON header
write-host "{"
write-host " `"data`":["
write-host

# For each object in the list of services, print the output of the JSON message with the object properties that we are interessted in
foreach ($objItem in $colItems) {
 $line =  " { `"{#PROCESSNAME}`":`"" + $objItem.Name + "`" , `"{#PROCESSDESCRIPTION}`":`"" + $objItem.Description + "`" , `"{#PROCESSID}`":`"" + $objItem.ProcessId + "`" , `"{#PROCESSCOMMANDLINE}`":`"" + $objItem.CommandLine + "`" },"
 write-host $line
}

# Close the JSON message
write-host
write-host " ]"
write-host "}"
write-host