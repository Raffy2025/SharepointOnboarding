<#
.SYNOPSIS
    Connects to the Onboarding SharePoint Communication site using PnP PowerShell.

.DESCRIPTION
    Interactive connection for local development. Do not hardcode credentials,
    client secrets, or tokens in this file or any script that sources it.

    Uses a dedicated single-tenant Entra ID app ("SharePoint-Onboarding-PnP"),
    registered via Register-PnPEntraIDAppForInteractiveLogin, since the
    tenant's Conditional Access policy blocks Microsoft's shared multi-tenant
    "PnP Management Shell" app from being provisioned at all.

    Uses -DeviceLogin (enter a code at microsoft.com/devicelogin) rather than
    -Interactive, since environments without a reliably visible browser popup
    can't complete the -Interactive sign-in flow.

.EXAMPLE
    . .\scripts\Connect-Onboarding.ps1
    Get-PnPWeb
#>

$SiteUrl = "https://jbsap365.sharepoint.com/sites/Onboarding"
$ClientId = "6dbd9d13-785a-49bc-86ac-68dce43548a5" # SharePoint-Onboarding-PnP (dedicated app registration)

if (-not (Get-Module -ListAvailable -Name PnP.PowerShell)) {
    Write-Host "PnP.PowerShell module not found. Installing for current user..." -ForegroundColor Yellow
    Install-Module -Name PnP.PowerShell -Scope CurrentUser -Force -AllowClobber
}

Import-Module PnP.PowerShell

Connect-PnPOnline -Url $SiteUrl -DeviceLogin -ClientId $ClientId

$connectedWeb = Get-PnPWeb
Write-Host "Connected to: $($connectedWeb.Title) ($($connectedWeb.Url))" -ForegroundColor Green
