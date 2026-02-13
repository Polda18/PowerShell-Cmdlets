function Resolve-PackIgnoreFile {
    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory=$true,
            Position=0,     # Position is set to 0 to allow for easier use of the function without named parameters
            HelpMessage="The source path where the .packignore file is located."
        )]
        [String] $SourcePath            # Source path has to be resolved
    )

    # Remove non-important parts
    $RegexComment = "^#.*$"             # Comments are lines beginning with "#"
    $RegexEmpty = "^\s*$"               # Empty lines (with only white space characters) should be ignored

    # Remove excessive white space characters
    $RegexTrimWhite = "^\s+|\s+$"       # Trim leading and trailing white space characters
    $RegexTrimExcess = "\s+"            # Trim excessive white space characters (multiple after each one)
                                        # and replace them with a new line

    # Build Ignoring arrays
    $FileContents = Get-Content "$($SourcePath)\.packignore"
    $FileContents = $FileContents -replace $RegexComment,"" -replace $RegexEmpty,""
    $FileContents = [String]::Join(" ", $FileContents)
    $FileContents = $FileContents -replace $RegexTrimWhite,"" -replace $RegexTrimExcess,"`n"
    
    Return $FileContents
}

function Build-MinecraftJavaPack {
    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory=$false,
            Position=0,     # Position is set to 0 to allow for easier use of the function without named parameters
            HelpMessage="The source path where the pack is to be built (default is current directory)"
        )]
        [String] $SourcePath,
        [Parameter(
            Mandatory=$true,
            Position=1,     # Position is set to 1 to allow for easier use of the function without named parameters
            HelpMessage="The name of the output file (without extension)"
        )]
        [String] $FileName)
    
    
    
    # Check if the filename you're trying to make is not a directory
    if(Test-Path $FileName -PathType Container) {
        Write-Host "Error! The pack filename is a directory!" -ForegroundColor Red
        Exit-PSHostProcess -1
    }
    
    # Read the specified path
    if(-not (Test-Path $SourcePath -PathType Container)) {
        $SourcePath = Resolve-Path "."
    } else {
        $SourcePath = $SourcePath -replace "`"", ""
        $SourcePath = $SourcePath -replace "'", ""
        $SourcePath = Resolve-Path $SourcePath
        $SourcePath = $SourcePath -replace "\\$",""
    }

    # Build the package using 7-Zip (Requires 7-Zip to be installed and added to $PATH)
    #----------------------------------------------------------------------------------

    # Create a temporary .packignore file with the resolved ignore patterns from the original .packignore file
    $(Resolve-PackIgnoreFile -SourcePath $SourcePath) | Out-File -FilePath .\.temp.packignore

    # Use 7-Zip to create a zip file with the specified filename, including all files from the source path,
    # and excluding files based on the .packignore file and the temporary .temp.packignore file
    Invoke-Expression "7z.exe u -tzip -up3q3r2x1y2z0w2 -x!'$($SourcePath)\.packignore' -x!'$($SourcePath)\.temp.packignore' -xr@'.temp.packignore' $($FileName) '$($SourcePath)\*'"

    # Remove the temporary .packignore file
    Remove-Item .\.temp.packignore
}

# Create an alias for the function to allow for easier use
Set-Alias -Name buildmcpack -Value Build-MinecraftJavaPack

# Export the function and the alias to be available when the module is imported
Export-ModuleMember -Function Build-MinecraftJavaPack
Export-ModuleMember -Alias buildmcpack
