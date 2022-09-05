Start-Transcript "$($env:ProgramData)\Microsoft\IntuneManagementExtension\CustomScript\Logs\AdobeCleanup.log"


$fileObj = Get-Item -Path "C:\ProgramData\InTuneScripts\Adobe.zip"

if (($fileObj.LastWriteTime) -lt (Get-Date).AddHours(-0.024)){

Remove-item C:\ProgramData\InTuneScripts\Adobe.zip, C:\ProgramData\InTuneScripts\Adobe\, C:\ProgramData\InTuneScripts\Fix-UpdateRequiredError.reg -Recurse

}

else {
Write-Output "File not old enough, waiting to remove"
}

Stop-Transcript