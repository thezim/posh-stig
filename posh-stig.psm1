function Get-Checklist {
    param(
        [ValidateNotNullOrEmpty()]
		[ValidateScript({Test-Path -PathType Leaf -Path $_})]
        [string]$Path
    )
    $data = @()
    $checklist = ([Xml](Get-Content -Raw -Path $Path)).CHECKLIST
    $info = @{        
        SV_VERSION = $checklist.SV_VERSION
        STIG_TITLE = $checklist.STIG_INFO.STIG_TITLE
    }
    foreach($node in $checklist.ASSET.ChildNodes){
        if($node.Name -ne "ASSET_VAL"){
            $info["$($node.Name)"] = $node.'#text'
        } else {
            $info["$($node.AV_NAME.'#text')"] = $node.AV_DATA.'#text'
        }
    }
    foreach($vuln in $checklist.VULN){
        $vulninfo = @{}
        foreach($node in $vuln.ChildNodes){
            if($node.Name -eq "STIG_DATA"){
                $vulninfo["$($node.VULN_ATTRIBUTE)"] = $node.ATTRIBUTE_DATA
            } else {
                $vulninfo["$($node.Name)"] = $node.'#text'
            }
        }
        $data += New-Object PSObject -Property ($vulninfo += $info)
    }
    $data
}

Set-Alias -Name 'gckl' -Value 'Get-Checklist' -Confirm:$false
Export-ModuleMember -Function Get-Checklist -Alias gckl