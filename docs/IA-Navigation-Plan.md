# Information Architecture & Navigation Plan — Onboarding Site

## Audience
- **Primary**: New hires
- **Secondary**: Hiring managers and onboarding buddies (need visibility into new-hire progress and their own checklist of responsibilities)

Some content is shared; some is role-specific. Role-specific content is called out below and can use SharePoint audience targeting on navigation links/web parts rather than a fully separate site.

## Content pillars
1. Pre-boarding & first day logistics
2. IT & systems setup
3. HR policies, benefits & compliance

(Culture/directory and team-specific resources are out of scope for this pass — flagged as a possible phase 2.)

## Top navigation
| Label | Target |
|---|---|
| Home | Site home page |
| Before You Start | Pre-boarding & first day logistics |
| IT & Systems | IT & systems setup |
| Policies & Benefits | HR policies, benefits & compliance |
| For Managers & Buddies | Manager/buddy hub (audience-targeted) |

## Page-level structure

### Home
- Welcome banner/hero (web part: Hero or Image)
- "Your first week at a glance" — quick links to the 3 pillars
- Highlighted announcements/news web part
- Contact/help card (who to reach for onboarding questions)

### Before You Start (Pre-boarding & first day logistics)
- Welcome letter / what to expect before day one
- What to bring / dress code
- First-day schedule template
- Office location, parking, building access instructions
- Emergency/facilities contacts

### IT & Systems
- Account activation steps (email, SSO, MFA setup)
- Hardware pickup/setup instructions
- Required software installs list
- VPN / remote access setup
- IT helpdesk contact + ticket submission link

### Policies & Benefits
- Employee handbook (linked document or embedded viewer)
- Leave policy summary
- Benefits enrollment steps and deadlines
- Payroll setup (bank details, tax forms)
- Mandatory compliance training checklist with due dates

### For Managers & Buddies (audience-targeted section)
- Manager's pre-arrival checklist (equipment request, workspace, access approvals)
- Buddy program expectations and suggested check-in cadence
- New-hire progress tracker (links to the onboarding checklist list)
- Escalation contacts (HR business partner, IT)

## Supporting lists/libraries (for `scripts/` provisioning)
- **Onboarding Checklist** list — tasks per pillar, assigned to new hire or manager/buddy, with due dates and completion status
- **Resources** document library — handbook, forms, templates referenced across pages
- **Contacts** list or simple page section — IT helpdesk, HR business partner, facilities

## Navigation mechanics
- Use SharePoint's built-in top navigation (max 5 items above, keeps it scannable)
- Quick launch (left nav) mirrors the same structure within each pillar's sub-pages if sub-pages are needed later
- Audience targeting: set the "For Managers & Buddies" nav node (and its page's manager-only web parts) to target the relevant SharePoint group so new hires aren't shown content that isn't for them

## Branding
- Using SharePoint default theme/layout for this pass; revisit once IA is validated and if brand guidelines are provided later

## Open items / phase 2 candidates
- Company culture & directory content (org chart, mission/values, employee directory)
- Role/team-specific resource pages
- Custom branding (theme colors, logo, fonts)

## Existing template pages (to be replaced)
The site was provisioned from Microsoft's built-in "Employee onboarding" look-book
template, which left these pages in place: `New-employee-training.aspx`,
`How-we-work.aspx`, `Meet-the-team.aspx`, `About-me.aspx`,
`Employee-onboarding-team-home.aspx`. Decision: our 4 pillar pages (Before You
Start, IT & Systems, Policies & Benefits, For Managers & Buddies) supersede
these. Not yet removed/redirected - follow-up task once our pages have real
content and the template pages' content has been reviewed for anything worth
carrying over.
