<#
.SYNOPSIS
    Connects to the Onboarding SharePoint Communication site using PnP PowerShell.

.DESCRIPTION
    Interactive connection for local development. Do not hardcode credentials,
    client secrets, or tokens in this file or any script that sources it.

.EXAMPLE
    . .\scripts\Connect-Onboarding.ps1
    Get-PnPWeb
#>

$SiteUrl = "https://jbsap365.sharepoint.com/sites/Onboarding"

if (-not (Get-Module -ListAvailable -Name PnP.PowerShell)) {
    Write-Host "PnP.PowerShell module not found. Installing for current user..." -ForegroundColor Yellow
    Install-Module -Name PnP.PowerShell -Scope CurrentUser -Force -AllowClobber
}

Import-Module PnP.PowerShell

Connect-PnPOnline -Url $SiteUrl -Interactive

$connectedWeb = Get-PnPWeb
Write-Host "Connected to: $($connectedWeb.Title) ($($connectedWeb.Url))" -ForegroundColor Green
