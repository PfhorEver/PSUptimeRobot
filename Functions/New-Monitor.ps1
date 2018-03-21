function New-Monitor {
    <#
    .SYNOPSIS
        Creates a new monitor on Uptime Robot
    
    .DESCRIPTION
        Implements the newMonitor rest endpoint of the Uptime Robot API v2
    
    .PARAMETER ApiKey
        The account ApiKey for your Uptime Robot account. The monitor ApiKey will not work with this function.
    
    .PARAMETER Name
        The name of the new monitor.

    .PARAMETER Type
        The type for the new moinitor

    .PARAMETER Url
        The URL the monitor will test. URLs must specify a protocol (e.g. http://www.example.com or https://www.example.com) 

    .PARAMETER ContactId
        The alert contact ID for the new monitor

    .LINKS
        https://uptimerobot.com/api
    
    #>
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true)]
        [string]$ApiKey,

        [Parameter(Mandatory=$true)]
        [string]$Name,

        [Parameter(Mandatory=$true)]
        [ValidateSet("HTTP","Keyword","Ping","Port")]
        [string]$Type,

        [Parameter(Mandatory=$true)]
        [string]$Url

    )

    Begin {
        [uri]$uri = "$urBaseUri/newMonitor"

        $body = "api_key=$ApiKey&format=json"

        if (    $Name   ) { $body += "&friendly_name={0}" -f $Name }
        if (    $Type   ) { $body += "&type={0}" -f ( [UptimeRobotMonitorType]::"$Type" ).value__ }
        if (    $Url    ) { $body += "&url={0}" -f "$Url" }

        $body | Write-Verbose
    }

    Process {
        $result = Invoke-RestMethod -Method Post -UseBasicParsing -Uri $uri.AbsoluteUri -Body $body -ContentType "application/x-www-form-urlencoded"
    }

    End {
        Write-Output $result
    }

}
