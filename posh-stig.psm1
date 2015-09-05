function Get-Checklist {
    param(
        [ValidateNotNullOrEmpty()]
		[ValidateScript({Test-Path -PathType Leaf -Path $_})]
        [string]$Path
    )
    $checklist = ([Xml](Get-Content -Raw -Path $Path)).CHECKLIST
    $assetinfo = @{}
    # parse asset information
    foreach($node in $checklist.ASSET.ChildNodes){
        if($node.Name -ne "ASSET_VAL"){
            $assetinfo["$($node.Name)"] = $node.'#text'
        } else {
            $assetinfo["$($node.AV_NAME.'#text')"] = $node.AV_DATA.'#text'
        }
    }
    $vulns = @()
    # parse vulnerablility data
    foreach($vuln in $checklist.VULN){
        $vulninfo = @{}
        foreach($node in $vuln.ChildNodes){
            if($node.Name -eq "STIG_DATA"){
                $vulninfo["$($node.VULN_ATTRIBUTE)"] = $node.ATTRIBUTE_DATA
            } else {
                $vulninfo["$($node.Name)"] = $node.'#text'
            }
        }
        $vulns += New-Object PSObject -Property @{
            Comments = $vulninfo.COMMENTS
            FindingDetails = $vulninfo.FINDING_DETAILS
            SeverityJustification = $vulninfo.SEVERITY_JUSTIFICATION
            SeverityOverride = $vulninfo.SEVERITY_OVERRIDE
            Status = $vulninfo.STATUS                   
            Data = New-Object PSObject -Property @{
                CheckContent = $vulninfo.Check_Content
                Check_Content_Ref = $vulninfo.Check_Content_Ref
                Class = $vulninfo.Class
                Documentable = $vulninfo.Documentable
                FalseNegatives = $vulninfo.False_Negatives
                FalsePositives = $vulninfo.False_Positives
                FixText = $vulninfo.Fix_Text
                GroupTitle = $vulninfo.Group_Title
                IAControls = $vulninfo.IA_Controls
                MitigationControl = $vulninfo.Mitigation_Control
                Mitigations = $vulninfo.Mitigations
                Potential_Impact = $vulninfo.Potential_Impact
                Responsibility = $vulninfo.Responsibility
                RuleId = $vulninfo.Rule_ID
                RuleTitle = $vulninfo.Rule_Title
                RuleVersion = $vulninfo.Rule_Ver
                STIGRef = $vulninfo.STIGRef
                SecurityOverrideGuidance = $vulninfo.Security_Override_Guidance
                Severity = $vulninfo.Severity
                TargetKey = $vulninfo.TargetKey
                ThirdPartyTools = $vulninfo.Third_Party_Tools
                VulnDiscuss = $vulninfo.Vuln_Discuss
                VulnNumber = $vulninfo.Vuln_Num
           }
        }
    }
    # return object
    New-Object PSObject -Property @{
        Title = $checklist.STIG_INFO.STIG_TITLE
        Version = $checklist.SV_VERSION
        Vulnerabilities = $vulns
        Asset = New-Object PSObject -Property @{
            AssetType = $assetinfo.ASSET_TYPE
            HostIP = $assetinfo.HOST_IP
            HostMAC = $assetinfo.HOST_MAC
            HostName = $assetinfo.HOST_NAME
            Role = $assetinfo.ROLE
            TargetKey = $assetinfo.TARGET_KEY
        }
    }
}

Set-Alias -Name 'gckl' -Value 'Get-Checklist' -Confirm:$false
Export-ModuleMember -Function Get-Checklist -Alias gckl