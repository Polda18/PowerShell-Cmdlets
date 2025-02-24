# PowerShell Cmdlets Collection
This repository has the collections of cmdlets for PowerShell.
If you want to use these, clone the repository and optionally
copy the files into the default installation directory
for PowerShell modules.

## Modules included in this repository:
- **Utils** — This module defines standalone cmdlets that are
  not part of any specific collection or module.

## Installation
Clone this repository and copy its contents to one
of the following directories:

### Windows Install
- Windows Powershell
```
$HOME\Documents\WindowsPowershell\Modules\
```
- PowerShell v7.0+ (Standalone)
```
$HOME\Documents\PowerShell\Modules\
```

### Linux/MacOS Install
```
$HOME/.local/share/powershell/Modules/
```

### Import
After installing the modules, you have to register them.
To register these modules, run the following commands
in PowerShell for each module:
```
PS > Import-Module Utils
```

## Usage
For complete usage, refer to the wiki.

### Utils module
This module defines standalone cmdlets that don't belong
to any specific module.

#### Build-MinecraftJavaPack
This cmdlet lets you to build a resource pack or data pack
for _Minecraft: Java Edition_. See the wiki for more info.

##### Dependencies
- 7-Zip (command line tool `7z`)

##### Usage
```
PS > Build-MinecraftResourcepack [-SourcePath <path to the source>] -Filename <filename of the datapack ZIP file>
```

#### Start-PythonWebserver
This cmdlet lets you to host a simple web server using Python's
built-in HTTP server. See the wiki for more info.

##### Dependencies
- Python

##### Usage
```
PS > Start-PythonWebserver [-Port <port assignment>] [-Path <path from which to serve>]
```

#### Publish-SteamWorkshopItem
This cmdlet lets you to upload a Steam Workshop item.
See the wiki for more info.

##### Dependencies
- Steam command line utility (SteamCMD)

##### Usage
```
PS > Publish-SteamWorkshopItem -Username <username or email> [-Password <your password to Steam> [-GuardCode <your Steam Guard code>]] -ItemDescriptor <VDF descriptor file>
```
