function Compare-BulkHashResults {
    [CmdletBinding()]
    param (
        [Parameter(
            Mandatory = $true,
            ValueFromPipeline = $true,
            Position = 0,
            HelpMessage = "The hash comparison results list to filter based on the expected result"
        )]
        [CompareHashResult[]]$InputResults,

        [Parameter(
            Mandatory = $false,
            HelpMessage = "The expected result (OK or FAILED)"
        )]
        [ValidateSet("OK", "FAILED")]
        [string]$ExpectedResult = "OK"
    )

    process {
        # Output the input results if they match the expected result
        $OutputResults = $InputResults | Where-Object -Property Result -eq $ExpectedResult
        return $OutputResults
    }
}

# Create an alias for the function to allow for easier use
Set-Alias -Name cbhashres -Value Compare-BulkHashResults

# Export the function and the alias to be available when the module is imported
Export-ModuleMember -Function Compare-BulkHashResults
Export-ModuleMember -Alias cbhashres
