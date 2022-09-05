<#
Version: 1.0
Author: Guy Kastner (guykastner.com)
Script: InstallAdobePro.ps1
Description:
Downloads Adobe Pro installer locally and runs MSI exec to install

Release notes:
Version 1.0: Original published version. 
The script is provided "AS IS" with no warranties.
#>


#Download Adobe installer
$appname = "InstallAdobePro"
$AdobeReg = "https://helpx.adobe.com/content/dam/help/en/x-productkb/global/update-operating-system-and-browser/jcr_content/root/content/flex/items/position/position-par/download_section/download-1/Fix-UpdateRequiredError.reg"
$AdobePro = "https://trials.adobe.com/AdobeProducts/APRO/Acrobat_HelpX/win32/Acrobat_DC_Web_x64_WWMUI.zip"
$AdobeInstalledPath = "C:\Program Files\Adobe\Acrobat DC\Acrobat\Acrobat.exe"
$Downloadfolder = "C:\ProgramData\InTuneScripts\Adobe\"
$applogo = 'C:\ProgramData\Microsoft\IntuneManagementExtension\intune.png'
Start-Transcript "$($env:ProgramData)\Microsoft\IntuneManagementExtension\CustomScript\Logs\$appname.log"


#Download IE reg fix use only if getting prompted on launching the app https://helpx.adobe.com/au/x-productkb/global/update-operating-system-and-browser.html?internal_browser=true
If (Test-Path 'C:\ProgramData\InTuneScripts\Fix-UpdateRequiredError.reg')
{ 
    echo 'Registry Already Downloaded'
} else {
Invoke-WebRequest -URI $AdobeReg -OutFile 'C:\ProgramData\InTuneScripts\Fix-UpdateRequiredError.reg'
Write-host 'Downloading Adobe Registry File from Web'
Start-Sleep -seconds 15
}

#Install IE reg fix

$process = Start-Process reg -ArgumentList "import C:\ProgramData\InTuneScripts\Fix-UpdateRequiredError.reg" -PassThru -Wait
$process.ExitCode


#Check for Download

If (Test-Path $Downloadfolder) {
    echo 'Installer Already Downloaded'
} Else {
    Invoke-WebRequest -URI $AdobePro -OutFile C:\ProgramData\InTuneScripts\Adobe.zip 
    Expand-Archive -Path C:\ProgramData\InTuneScripts\Adobe.zip -DestinationPath C:\ProgramData\InTuneScripts\Adobe\
        
}

#Wait for download and unzip
Start-Sleep -Seconds 400
#Install Adobe Pro
If (Test-Path $AdobeInstalledPath) {
    echo 'Adobe Pro already installed'
    exit
    } Else {
    msiexec /i "C:\ProgramData\InTuneScripts\Adobe\Adobe Acrobat\AcroPro.msi" /qn
    }

Stop-Transcript
