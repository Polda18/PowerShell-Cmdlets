function Resolve-PackIgnoreFile {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
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
        [Parameter(Mandatory=$false)]
        [String] $SourcePath,
        [Parameter(Mandatory=$true)]
        [String] $FileName)
    
    # Check if the filename you're trying to make is not a directory
    if(Test-Path $Filename -PathType Container) {
        Write-Output "Error! The pack filename is a directory!"
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
    $(Resolve-PackIgnoreFile -SourcePath $SourcePath) | Out-File -FilePath .\.temp.packignore
    Invoke-Expression "7z.exe u -tzip -up3q3r2x1y2z0w2 -x!'$($SourcePath)\.packignore' -x!'$($SourcePath)\.temp.packignore' -xr@'.temp.packignore' $($FileName) `"$($SourcePath)\*`""
    Remove-Item .\.temp.packignore
}
Export-ModuleMember -Function Build-MinecraftJavaPack
