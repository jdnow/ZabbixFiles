param(
	[Parameter(Mandatory=$True)]
	[string]$QueryName
)

switch ($QueryName)
{
('SerialNumber') {gwmi win32_Bios | select SerialNumber | Format-Table -HideTableHeaders}
('BIOSVersion') {gwmi win32_Bios | select SMBIOSBIOSVersion | Format-Table -HideTableHeaders}
('Manufacture') {gwmi win32_ComputerSystemProduct | select Vendor | Format-Table -HideTableHeaders}
('MachineType') {gwmi win32_ComputerSystemProduct | select Name | Format-Table -HideTableHeaders}
('OSVersion') {gwmi win32_OperatingSystem | select Version| Format-Table -HideTableHeaders}
('InstalledSoftware') {gwmi win32_Product | select Name | Format-Table -HideTableHeaders}
default {Write-Host "Incorrect Command Given"}
}

