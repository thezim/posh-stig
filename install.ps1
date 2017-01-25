$files = @("posh-stig.psd1", "posh-stig.psm1", "README.md")
$delimiter = [System.IO.Path]::PathSeparator
$modpath = "{0}\posh-stig" -f ($env:PSModulePath -split $delimiter | Select-Object -First 1)
if((Test-Path -Path $modpath) -eq $false){
    New-Item -ItemType Directory -Path $modpath | Out-Null
}
Copy-Item -Force -Path $files -Destination $modpath