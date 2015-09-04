Import-Module .\posh-stig.psm1
Get-Checklist -Path .\stig.ckl | Out-GridView