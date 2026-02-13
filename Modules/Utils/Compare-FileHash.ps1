function Compare-FileHash {
    [CmdletBinding()]
    param (
        [Parameter(
            Mandatory = $false,
            HelpMessage = "The hash algorithm to use (default is SHA256)"
        )]
        [ValidateSet("MD5", "SHA1", "SHA256", "SHA384", "SHA512")]
        [string]$Algorithm = "SHA256",

        [Parameter(
            Mandatory = $true,
            Position = 0,
            HelpMessage = "The path to the file to be compared"
        )]
        [string]$Path,

        [Parameter(
            Mandatory = $true,
            HelpMessage = "The expected hash value of the file"
        )]
        [Alias("Hash")]
        [string]$ExpectedHash
    )

    if (-not (Test-Path -Path $Path -PathType Leaf)) {
        $exceptionMessage = "Error: The specified file does not exist."
        $exception = New-Object System.IO.FileNotFoundException($exceptionMessage, $Path)
        throw $exception
    }

    try {
        $fileHash = Get-FileHash -Path $Path -Algorithm $Algorithm
        
        # Output the result as a custom object for better readability
        return [CompareHashResult]@{
            Path = $fileHash.Path
            Result = if ($fileHash.Hash -eq $ExpectedHash) { "OK" } else { "FAILED" }
        }
    } catch {
        $exceptionMessage = "An error occurred while calculating the file hash."
        $exception = New-Object System.Exception($exceptionMessage, $_)
        throw $exception
    }
}

# Create an alias for the function to allow for easier use
Set-Alias -Name cfhash -Value Compare-FileHash

# Export the function and the alias to be available when the module is imported
Export-ModuleMember -Function Compare-FileHash
Export-ModuleMember -Alias cfhash
