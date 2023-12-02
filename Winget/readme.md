# WinGet Installer Script

This PowerShell script installs the WinGet package manager on a Windows machine.

## Description

The script first checks if WinGet is already installed. If it is, the script exits. If not, it proceeds to download and install the required dependencies (VCLibs, UI.Xaml) and then installs WinGet.

## Usage

To run the script, open a PowerShell terminal with administrative privileges and navigate to the directory containing the script. Then, run the following command:

```powershell
.\Winget.ps1