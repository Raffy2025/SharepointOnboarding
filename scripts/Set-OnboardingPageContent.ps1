<#
.SYNOPSIS
    Fills the 4 onboarding pillar pages with draft content per the IA plan.

.DESCRIPTION
    Requires an active PnP connection - run scripts\Connect-Onboarding.ps1 first.
    Replaces the placeholder text control on each page with structured
    section headings and body copy matching docs\IA-Navigation-Plan.md.

    This is DRAFT content. Anything in [square brackets] is a placeholder
    for real company-specific detail (contacts, tool names, policy specifics,
    dates) - review and replace before publishing to end users. Re-running
    this script replaces prior content on these 4 pages each time.
#>

if (-not (Get-PnPConnection)) {
    throw "Not connected. Run scripts\Connect-Onboarding.ps1 first."
}

function Set-PageContent {
    param(
        [string]$PageName,
        [string]$Html
    )

    $page = Get-PnPPage -Identity $PageName
    @($page.Controls) | ForEach-Object { Remove-PnPPageComponent -Page $page -InstanceId $_.InstanceId -Force }
    Add-PnPPageTextPart -Page $PageName -Text $Html
    Set-PnPPage -Identity $PageName -Publish
    Write-Host "Updated content: $PageName" -ForegroundColor Green
}

Set-PageContent -PageName "Before-You-Start" -Html @"
<h2>Welcome</h2>
<p>[Insert welcome letter - what to expect before day one, who will be in touch, and when.]</p>
<h2>What to bring / dress code</h2>
<ul>
<li>[Identification/documents to bring on day one]</li>
<li>[Dress code guidance]</li>
</ul>
<h2>First-day schedule</h2>
<p>[Insert first-day schedule template - arrival time, orientation agenda, who to meet.]</p>
<h2>Office location & access</h2>
<p>[Office address, parking instructions, building access/badge process.]</p>
<h2>Emergency & facilities contacts</h2>
<p>[Facilities contact name/number, emergency procedures.]</p>
"@

Set-PageContent -PageName "IT-Systems" -Html @"
<h2>Account activation</h2>
<p>[Steps to activate email, SSO, and MFA setup.]</p>
<h2>Hardware pickup & setup</h2>
<p>[Where/when to collect hardware, initial setup steps.]</p>
<h2>Required software</h2>
<ul>
<li>[Software/tool 1]</li>
<li>[Software/tool 2]</li>
</ul>
<h2>VPN & remote access</h2>
<p>[VPN client, remote access setup instructions.]</p>
<h2>IT helpdesk</h2>
<p>[Helpdesk contact and ticket submission link.]</p>
"@

Set-PageContent -PageName "Policies-Benefits" -Html @"
<h2>Employee handbook</h2>
<p>[Link to the employee handbook document.]</p>
<h2>Leave policy</h2>
<p>[Summary of leave policy - types, accrual, how to request.]</p>
<h2>Benefits enrollment</h2>
<p>[Benefits enrollment steps and deadlines.]</p>
<h2>Payroll setup</h2>
<p>[Bank details and tax form submission instructions.]</p>
<h2>Mandatory compliance training</h2>
<p>[Checklist of required training modules and due dates.]</p>
"@

Set-PageContent -PageName "Managers-Buddies" -Html @"
<h2>Manager's pre-arrival checklist</h2>
<ul>
<li>[Equipment request]</li>
<li>[Workspace setup]</li>
<li>[Access approvals]</li>
</ul>
<h2>Buddy program</h2>
<p>[Buddy program expectations and suggested check-in cadence.]</p>
<h2>New-hire progress tracker</h2>
<p>Track progress via the <a href="/sites/Onboarding/Lists/Onboarding%20Checklist">Onboarding Checklist</a> list.</p>
<h2>Escalation contacts</h2>
<p>[HR business partner and IT escalation contacts.]</p>
"@

Write-Host "All pillar pages updated with draft content." -ForegroundColor Green
