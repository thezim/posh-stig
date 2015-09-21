$files = @("posh-stig.psd1", "posh-stig.psm1")
$modpath = "{0}\posh-stig" -f ($env:PSModulePath -split ';' | Select-Object -First 1)
if((Test-Path -Path $modpath) -eq $false){
    New-Item -ItemType Directory -Path $modpath | Out-Null
}
Copy-Item -Force -Path $files -Destination $modpath