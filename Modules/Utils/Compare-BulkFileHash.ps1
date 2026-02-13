function Compare-BulkFileHash {
    [CmdletBinding()]
    param (
        [Parameter(
            Mandatory = $true,
            Position = 0,
            HelpMessage = "Path to a text file containing lines in the format: <Hash>  <FilePath> (with two spaces between the hash and the file path)"
        )]
        [string]$Path,

        [Parameter(
            Mandatory = $false,
            HelpMessage = "The hash algorithm to use (default is SHA256)"
        )]
        [ValidateSet("MD5", "SHA1", "SHA256", "SHA384", "SHA512")]
        [string]$Algorithm = "SHA256",

        [Parameter(
            Mandatory = $false,
            HelpMessage = "Include missing files in the output with a result of FAILED (default is false)"
        )]
        [switch]$IncludeMissingFiles
    )

    if (-not (Test-Path -Path $Path -PathType Leaf)) {
        $ExceptionMessage = "Error: The specified file does not exist."
        $Exception = New-Object System.IO.FileNotFoundException($ExceptionMessage, $Path)
        throw $Exception
    }

    # Read the file containing the list of file paths and their expected hashes, and compare each file's hash to the expected hash
    [CompareHashResult[]]$fileHashes = Get-Content -Path $Path | ForEach-Object {
        $Hash, $_, $File = $_.Split(" ", 3)
        if ($Hash) {
            $Result = if (Test-Path -Path $File -PathType Leaf) {
                if ($Hash -eq (Get-FileHash -Path $File -Algorithm $Algorithm).Hash) { "OK" } else { "FAILED" }
            } else {
                if ($IncludeMissingFiles) { "FAILED" } else { return }
            }
            return [CompareHashResult]@{
                Path = $File
                Result = $Result
            }
        }
    }

    # Output the results
    return $fileHashes
}

# Create an alias for the function to allow for easier use
Set-Alias -Name cbhash -Value Compare-BulkFileHash

# Export the function and the alias to be available when the module is imported
Export-ModuleMember -Function Compare-BulkFileHash
Export-ModuleMember -Alias cbhash
