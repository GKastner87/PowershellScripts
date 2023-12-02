<#
Version: 1.0
Author: Guy Kastner (guykastner.com)
Script: CleanUp-OldAdobeFiles.ps1
Description:
Waits 24 hours to clean up the Adobe Installer files from InstallAdobePro.ps1 script
Release notes:
Version 1.0: Original published version. 
The script is provided "AS IS" with no warranties.
#>

Start-Transcript "$($env:ProgramData)\Microsoft\IntuneManagementExtension\CustomScript\Logs\AdobeCleanup.log"


$fileObj = Get-Item -Path "C:\ProgramData\InTuneScripts\Adobe.zip"

if (($fileObj.LastWriteTime) -lt (Get-Date).AddHours(-0.024)){

Remove-item C:\ProgramData\InTuneScripts\Adobe.zip, C:\ProgramData\InTuneScripts\Adobe\, C:\ProgramData\InTuneScripts\Fix-UpdateRequiredError.reg -Recurse

}

else {
Write-Output "File not old enough, waiting to remove"
}

Stop-Transcript
