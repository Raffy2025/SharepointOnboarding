<#
.SYNOPSIS
    Creates the page shells for each onboarding pillar on the Onboarding site.

.DESCRIPTION
    Requires an active PnP connection - run scripts\Connect-Onboarding.ps1 first.
    Creates one page per pillar with a heading text web part, left unpublished
    so content can be filled in before going live. Safe to re-run: pages that
    already exist are skipped.
#>

if (-not (Get-PnPConnection)) {
    throw "Not connected. Run scripts\Connect-Onboarding.ps1 first."
}

$pages = @(
    @{ Name = "Before-You-Start"; Title = "Before You Start" },
    @{ Name = "IT-Systems"; Title = "IT & Systems" },
    @{ Name = "Policies-Benefits"; Title = "Policies & Benefits" },
    @{ Name = "Managers-Buddies"; Title = "For Managers & Buddies" }
)

foreach ($page in $pages) {
    if (Get-PnPPage -Identity $page.Name -ErrorAction SilentlyContinue) {
        Write-Host "Page already exists: $($page.Title)" -ForegroundColor Yellow
        continue
    }

    $newPage = Add-PnPPage -Name $page.Name -Title $page.Title -LayoutType Article
    Add-PnPPageTextPart -Page $newPage -Text "Content for $($page.Title) goes here."
    Write-Host "Created page: $($page.Title) ($($page.Name).aspx)" -ForegroundColor Green
}

Write-Host "Onboarding pages are up to date. Pages are unpublished - review content before publishing." -ForegroundColor Green
