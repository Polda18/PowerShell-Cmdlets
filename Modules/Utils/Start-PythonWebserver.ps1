function Start-PythonWebserver {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$false)]
        [UInt16] $Port=8080,
        [Parameter(Mandatory=$false)]
        [String] $Path)

    $PrevPath = Get-Location
    if(-not $Path -eq $null -and -not $Path -eq "") {
        $Path = $Path -replace "`"", ""
        $Path = $Path -replace "'", ""
        Set-Location $Path
    }
    python3 -m http.server $Port
    Set-Location $PrevPath
}
Export-ModuleMember -Function Start-PythonWebserver
