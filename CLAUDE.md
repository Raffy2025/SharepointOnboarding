# SharePoint Onboarding Site

Project for designing and customizing the "Onboarding" SharePoint Communication site using PnP PowerShell and custom HTML.

## Site details
- Site type: Communication site
- Site URL: https://jbsap365.sharepoint.com/sites/Onboarding
- Tenant: jbsap365

## Tooling
- PowerShell (PnP.PowerShell module) for connecting to and provisioning/customizing the site
- Connect via `Connect-PnPOnline` (interactive or app-only, TBD)
- HTML/CSS/JS for custom page content and web part content where SharePoint's native tooling isn't sufficient

## Folder structure
- `scripts/` — PnP PowerShell scripts (connection, provisioning, branding, list/library setup)
- `assets/` — HTML/CSS/JS for custom page content
- `docs/` — site design notes, information architecture, navigation plan

## Conventions
- Never commit tenant credentials, client secrets, or auth tokens. Use `Connect-PnPOnline -Interactive` for local dev unless told otherwise.
- Confirm with the user before running any script that modifies the live site (page publishing, navigation changes, permission changes, deletions).
