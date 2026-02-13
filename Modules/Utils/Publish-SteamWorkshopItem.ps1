function Publish-SteamWorkshopItem {
    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory=$true,
            Position=0,     # Position is set to 0 to allow for easier use of the function without named parameters
            HelpMessage="The item descriptor file to use for publishing the workshop item"
        )]
        [System.IO.FileInfo] $ItemDescriptor,
        [Parameter(
            Mandatory=$true,
            HelpMessage="The Steam username to use for authenticating the user"
        )]
        [String] $Username,
        [Parameter(
            Mandatory=$true,
            HelpMessage="The password to use for authenticating the user"
        )]
        [SecureString] $Password,
        [Parameter(
            Mandatory=$false,
            HelpMessage="The Steam Guard code to use for authenticating the user, if required"
        )]
        [String] $GuardCode
    )
    
    # Resolve the item descriptor file path, and check if it exists or stop execution if it doesn't
    $ItemDescriptor = Resolve-Path $ItemDescriptor -ErrorAction Stop

    # Build login string using the provided username and password, and optionally the guard code if it's provided
    $login_str = "+login $($Username) $(ConvertFrom-SecureString $Password)"
    if ($GuardCode) {
        $login_str = "$($login_str) $(GuardCode)"
    }

    # Connect to Steam via SteamCMD and upload the item
    Invoke-Expression "steamcmd.exe $($login_str) +workshop_build_item $($ItemDescriptor) +quit"
}

# Create aliases for the function to allow for easier use
Set-Alias -Name pwsitem -Value Publish-SteamWorkshopItem
Set-Alias -Name pstwsi -Value Publish-SteamWorkshopItem

# Export the function and the alias to be available when the module is imported
Export-ModuleMember -Function Publish-SteamWorkshopItem
Export-ModuleMember -Alias pwsitem, pstwsi
