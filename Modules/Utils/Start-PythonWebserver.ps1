function Start-PythonWebserver {
    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory=$false,
            Position=0,     # Position is set to 0 to allow for easier use of the function without named parameters
            HelpMessage="The path to serve the webserver from (default is current directory)"
        )]
        [String] $Path,
        [Parameter(
            Mandatory=$false,
            HelpMessage="The port to serve the webserver on (default is 8080)"
        )]
        [UInt16] $Port=8080
    )

    $PrevPath = Get-Location        # Store the previous path to return to it after the server is stopped

    # Change to the specified path if it exists, otherwise use the current directory
    if(-not $Path -eq $null -and -not $Path -eq "") {
        $Path = $Path -replace "`"", ""
        $Path = $Path -replace "'", ""
        Set-Location $Path
    }

    python3 -m http.server $Port    # Start the Python webserver on the specified port
    Set-Location $PrevPath          # Return to the previous path after the server is stopped
}

# Create aliases for the function to allow for easier use
Set-Alias -Name serve -Value Start-PythonWebserver
Set-Alias -Name startwebserver -Value Start-PythonWebserver

# Export the function and the aliases to be available when the module is imported
Export-ModuleMember -Function Start-PythonWebserver
Export-ModuleMember -Alias serve, startwebserver
