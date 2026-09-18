<#
.SYNOPSIS
    Creates top navigation for the Onboarding site.

.DESCRIPTION
    Requires an active PnP connection - run scripts\Connect-Onboarding.ps1 first.
    Creates one top nav node per pillar page. "For Managers & Buddies" can be
    audience-targeted once a security/M365 group for managers & buddies
    exists - set $ManagersBuddiesGroupId below to that group's object ID to
    enable it; leave blank to create the node visible to everyone for now.

    Safe to re-run: nodes with a matching title are skipped rather than duplicated.
#>

if (-not (Get-PnPConnection)) {
    throw "Not connected. Run scripts\Connect-Onboarding.ps1 first."
}

$ManagersBuddiesGroupId = ""  # set to an Entra group object ID to enable audience targeting

$navItems = @(
    @{ Title = "Before You Start"; Url = "/sites/Onboarding/SitePages/Before-You-Start.aspx" },
    @{ Title = "IT & Systems"; Url = "/sites/Onboarding/SitePages/IT-Systems.aspx" },
    @{ Title = "Policies & Benefits"; Url = "/sites/Onboarding/SitePages/Policies-Benefits.aspx" },
    @{ Title = "For Managers & Buddies"; Url = "/sites/Onboarding/SitePages/Managers-Buddies.aspx" }
)

$existingNodes = Get-PnPNavigationNode -Location TopNavigationBar

foreach ($item in $navItems) {
    if ($existingNodes | Where-Object { $_.Title -eq $item.Title }) {
        Write-Host "Nav node already exists: $($item.Title)" -ForegroundColor Yellow
        continue
    }

    $params = @{
        Location = "TopNavigationBar"
        Title    = $item.Title
        Url      = $item.Url
    }

    if ($item.Title -eq "For Managers & Buddies" -and $ManagersBuddiesGroupId) {
        $params.AudienceIds = @([guid]$ManagersBuddiesGroupId)
    }

    try {
        Add-PnPNavigationNode @params -ErrorAction Stop | Out-Null
        Write-Host "Created nav node: $($item.Title)" -ForegroundColor Green
    }
    catch {
        Write-Host "Failed to create nav node: $($item.Title) - $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host "Onboarding top navigation is up to date." -ForegroundColor Green
