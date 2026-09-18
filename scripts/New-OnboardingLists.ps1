<#
.SYNOPSIS
    Creates the Onboarding Checklist list and Resources library on the Onboarding site.

.DESCRIPTION
    Requires an active PnP connection - run scripts\Connect-Onboarding.ps1 first.
    Safe to re-run: each list/field is created only if it doesn't already exist.
#>

if (-not (Get-PnPConnection)) {
    throw "Not connected. Run scripts\Connect-Onboarding.ps1 first."
}

$pillars = "Before You Start", "IT & Systems", "Policies & Benefits", "For Managers & Buddies"

# Onboarding Checklist list
if (-not (Get-PnPList -Identity "Onboarding Checklist" -ErrorAction SilentlyContinue)) {
    New-PnPList -Title "Onboarding Checklist" -Template GenericList -OnQuickLaunch -EnableContentTypes | Out-Null
    Write-Host "Created list: Onboarding Checklist" -ForegroundColor Green
}

Add-PnPField -List "Onboarding Checklist" -DisplayName "Pillar" -InternalName "OnboardingPillar" -Type Choice -Choices $pillars -AddToDefaultView -ErrorAction SilentlyContinue
Add-PnPField -List "Onboarding Checklist" -DisplayName "Assigned To" -InternalName "OnboardingAssignedTo" -Type User -AddToDefaultView -ErrorAction SilentlyContinue
Add-PnPField -List "Onboarding Checklist" -DisplayName "Due Date" -InternalName "OnboardingDueDate" -Type DateTime -AddToDefaultView -ErrorAction SilentlyContinue
Add-PnPField -List "Onboarding Checklist" -DisplayName "Status" -InternalName "OnboardingStatus" -Type Choice -Choices "Not Started", "In Progress", "Completed" -AddToDefaultView -ErrorAction SilentlyContinue

# Resources library
if (-not (Get-PnPList -Identity "Resources" -ErrorAction SilentlyContinue)) {
    New-PnPList -Title "Resources" -Template DocumentLibrary -OnQuickLaunch -EnableContentTypes | Out-Null
    Write-Host "Created library: Resources" -ForegroundColor Green
}

Add-PnPField -List "Resources" -DisplayName "Pillar" -InternalName "ResourcePillar" -Type Choice -Choices $pillars -AddToDefaultView -ErrorAction SilentlyContinue

Write-Host "Onboarding lists/libraries are up to date." -ForegroundColor Green
