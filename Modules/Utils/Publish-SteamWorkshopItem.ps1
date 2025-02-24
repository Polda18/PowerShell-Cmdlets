function Publish-SteamWorkshopItem {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [String] $Username,
        [Parameter(Mandatory=$false)]
        [SecureString] $Password,
        [Parameter(Mandatory=$false)]
        [String] $GuardCode,
        [Parameter(Mandatory=$true)]
        [System.IO.FileInfo] $ItemDescriptor
    )
    
    # Resolve the item descriptor file path
    $ItemDescriptor = Resolve-Path $ItemDescriptor -ErrorAction Stop

    # Build login string
    $login_str = "+login $($Username)"
    if ($Password) {
        $login_str = "$($login_str) $(ConvertFrom-SecureString $Password)"

        if ($GuardCode) {
            $login_str = "$($login_str) $(GuardCode)"
        }
    }

    # Connect to Steam via SteamCMD and upload the item
    Invoke-Expression "steamcmd.exe $($login_str) +workshop_build_item $($ItemDescriptor) +quit"
}
Export-ModuleMember -Function Publish-SteamWorkshopItem
