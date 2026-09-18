<#
.SYNOPSIS
    Builds a structured, multi-section layout with draft content for the
    Home page and the 4 onboarding pillar pages.

.DESCRIPTION
    Requires an active PnP connection - run scripts\Connect-Onboarding.ps1 first.
    Each page gets: a colored intro band (OneColumnFullWidth), a two-column
    body section with Divider web parts between topics, and a closing
    "Related resources" links section - instead of one long plain-text block.

    This is DRAFT content. Anything in [square brackets] is a placeholder
    for real company-specific detail (contacts, tool names, policy specifics,
    dates) - review and replace before publishing to end users. Re-running
    this script replaces prior content/layout on these pages each time.
#>

if (-not (Get-PnPConnection)) {
    throw "Not connected. Run scripts\Connect-Onboarding.ps1 first."
}

function Add-ContentBlocks {
    param($PageName, [int]$Section, [int]$Column, [array]$Blocks)

    $order = 1
    foreach ($block in $Blocks) {
        if ($order -gt 1) {
            Add-PnPPageWebPart -Page $PageName -DefaultWebPartType Divider -Section $Section -Column $Column -Order $order | Out-Null
            $order++
        }
        Add-PnPPageTextPart -Page $PageName -Text "<h3>$($block.Heading)</h3><p>$($block.Body)</p>" -Section $Section -Column $Column -Order $order | Out-Null
        $order++
    }
}

function Build-Page {
    param(
        [string]$PageName,
        [string]$Intro,
        [array]$LeftBlocks,
        [array]$RightBlocks,
        [string]$LinksHtml,
        [bool]$CommentsEnabled = $true
    )

    $page = Get-PnPPage -Identity $PageName
    $page.ClearPage()
    $page.Save()

    Add-PnPPageSection -Page $PageName -SectionTemplate OneColumn -Order 1 -ZoneEmphasis 2 | Out-Null
    Add-PnPPageTextPart -Page $PageName -Text "<p class=`"fontSizeLarge`">$Intro</p>" -Section 1 -Column 1 | Out-Null

    Add-PnPPageSection -Page $PageName -SectionTemplate TwoColumn -Order 2 | Out-Null
    Add-ContentBlocks -PageName $PageName -Section 2 -Column 1 -Blocks $LeftBlocks
    Add-ContentBlocks -PageName $PageName -Section 2 -Column 2 -Blocks $RightBlocks

    Add-PnPPageSection -Page $PageName -SectionTemplate OneColumn -Order 3 -ZoneEmphasis 1 | Out-Null
    Add-PnPPageTextPart -Page $PageName -Text "<h3>Related resources</h3>$LinksHtml" -Section 3 -Column 1 | Out-Null

    Set-PnPPage -Identity $PageName -CommentsEnabled:$CommentsEnabled -Publish
    Write-Host "Rebuilt page: $PageName" -ForegroundColor Green
}

$checklistLink = '<a href="/sites/Onboarding/Lists/Onboarding%20Checklist">Onboarding Checklist</a>'
$resourcesLink = '<a href="/sites/Onboarding/Resources">Resources library</a>'

Build-Page -PageName "Home" -Intro "Welcome! This is your home base for getting started - everything you need for your first weeks is organized below." `
    -LeftBlocks @(
        @{ Heading = "Before You Start"; Body = 'Pre-boarding info and first-day logistics. <a href="/sites/Onboarding/SitePages/Before-You-Start.aspx">Go to page</a>.' },
        @{ Heading = "IT & Systems"; Body = 'Account setup, hardware, and software. <a href="/sites/Onboarding/SitePages/IT-Systems.aspx">Go to page</a>.' }
    ) `
    -RightBlocks @(
        @{ Heading = "Policies & Benefits"; Body = 'Handbook, leave, benefits, payroll, training. <a href="/sites/Onboarding/SitePages/Policies-Benefits.aspx">Go to page</a>.' },
        @{ Heading = "For Managers & Buddies"; Body = 'Checklists and resources for the support team. <a href="/sites/Onboarding/SitePages/Managers-Buddies.aspx">Go to page</a>.' }
    ) `
    -LinksHtml "<ul><li>$checklistLink</li><li>$resourcesLink</li></ul>"

Build-Page -PageName "Before-You-Start" -Intro "Here's everything you need to know before your first day." `
    -LeftBlocks @(
        @{ Heading = "Welcome"; Body = "[Insert welcome letter - what to expect before day one, who will be in touch, and when.]" },
        @{ Heading = "What to bring / dress code"; Body = "[Identification/documents to bring on day one. Dress code guidance.]" },
        @{ Heading = "First-day schedule"; Body = "[Insert first-day schedule template - arrival time, orientation agenda, who to meet.]" }
    ) `
    -RightBlocks @(
        @{ Heading = "Office location & access"; Body = "[Office address, parking instructions, building access/badge process.]" },
        @{ Heading = "Emergency & facilities contacts"; Body = "[Facilities contact name/number, emergency procedures.]" }
    ) `
    -LinksHtml "<ul><li>$checklistLink</li><li>$resourcesLink</li></ul>" `
    -CommentsEnabled $false

Build-Page -PageName "IT-Systems" -Intro "Get your accounts, devices, and tools set up and ready to go." `
    -LeftBlocks @(
        @{ Heading = "Account activation"; Body = "[Steps to activate email, SSO, and MFA setup.]" },
        @{ Heading = "Hardware pickup & setup"; Body = "[Where/when to collect hardware, initial setup steps.]" }
    ) `
    -RightBlocks @(
        @{ Heading = "Required software"; Body = "[Software/tool 1. Software/tool 2.]" },
        @{ Heading = "VPN & remote access"; Body = "[VPN client, remote access setup instructions.]" },
        @{ Heading = "IT helpdesk"; Body = "[Helpdesk contact and ticket submission link.]" }
    ) `
    -LinksHtml "<ul><li>$resourcesLink</li></ul>" `
    -CommentsEnabled $false

Build-Page -PageName "Policies-Benefits" -Intro "Understand your benefits, policies, and what's required of you." `
    -LeftBlocks @(
        @{ Heading = "Employee handbook"; Body = "[Link to the employee handbook document.]" },
        @{ Heading = "Leave policy"; Body = "[Summary of leave policy - types, accrual, how to request.]" }
    ) `
    -RightBlocks @(
        @{ Heading = "Benefits enrollment"; Body = "[Benefits enrollment steps and deadlines.]" },
        @{ Heading = "Payroll setup"; Body = "[Bank details and tax form submission instructions.]" },
        @{ Heading = "Mandatory compliance training"; Body = "[Checklist of required training modules and due dates.]" }
    ) `
    -LinksHtml "<ul><li>$resourcesLink</li><li>$checklistLink</li></ul>" `
    -CommentsEnabled $false

Build-Page -PageName "Managers-Buddies" -Intro "Resources for managers and buddies supporting a new hire." `
    -LeftBlocks @(
        @{ Heading = "Manager's pre-arrival checklist"; Body = "[Equipment request. Workspace setup. Access approvals.]" },
        @{ Heading = "Buddy program"; Body = "[Buddy program expectations and suggested check-in cadence.]" }
    ) `
    -RightBlocks @(
        @{ Heading = "New-hire progress tracker"; Body = "Track progress via the $checklistLink." },
        @{ Heading = "Escalation contacts"; Body = "[HR business partner and IT escalation contacts.]" }
    ) `
    -LinksHtml "<ul><li>$checklistLink</li></ul>" `
    -CommentsEnabled $false

Write-Host "All pages rebuilt with structured layout and draft content." -ForegroundColor Green
