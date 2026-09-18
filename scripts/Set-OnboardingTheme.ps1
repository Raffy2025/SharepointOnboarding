<#
.SYNOPSIS
    Applies a professional color theme to the Onboarding site.

.DESCRIPTION
    Requires an active PnP connection - run scripts\Connect-Onboarding.ps1 first.
    Uses one of SharePoint's built-in tenant themes rather than a custom
    palette, since no brand guidelines have been provided yet. Revisit once
    real brand colors/logo are available.
#>

if (-not (Get-PnPConnection)) {
    throw "Not connected. Run scripts\Connect-Onboarding.ps1 first."
}

Set-PnPWebTheme -Theme "Blue"
Write-Host "Applied theme: Blue" -ForegroundColor Green
