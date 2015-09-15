#posh-stig
####NAME

Import-Checklist

####SYNOPSIS

Imports a STIG checklist file and converts it into a custom object.

####SYNTAX

Import-Checklist [-Path] <String> [<CommonParameters>]

####DESCRIPTION

Imports a STIG (Security Technical Implementation Guide) file and converts it into a
custom object to be viewed or used by another PowerShell cmdlet.

####PARAMETERS

-Path <String>
Specifies the path to the checklist file.

<CommonParameters>
This cmdlet supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, WarningVariable, OutBuffer, PipelineVariable, and OutVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

-------------------------- EXAMPLE 1 --------------------------

``` powershell
PS C:\>Import-Checklist -Path C:\temp\filename.ckl
```
Will Import the checklist file "filename.ckl" from C:\temp\

####REMARKS

To see the examples, type: "get-help Import-Checklist -examples".  
For more information, type: "get-help Import-Checklist -detailed".  
For technical information, type: "get-help Import-Checklist -full".  
For online help, type: "get-help Import-Checklist -online"  
