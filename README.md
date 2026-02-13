# PowerShell Cmdlets Collection

This repository has the collections of cmdlets for PowerShell. If you want to use these, clone the repository and optionally copy the included modules into the default installation directory for PowerShell modules.

## Modules included in this repository

- **Utils**: This module defines standalone cmdlets that do not require any additional software to run.
- **PackingUtils**: This module defines cmdlets that may be dependent on various packing software. Read the dependency section to learn which packing software may be needed. You may have an option as well. Soft dependencies are optional and cmdlets with soft dependencies include logic to determine which software to use.
- **SteamUtils**: This module defines cmdlets that utilize the Steam CLI. This module has one hard dependency, which is the Steam CLI installed on your system.
- **PythonUtils**: This module defines cmdlets utilizing various Python tools, such as built-in simple HTTP server.

## Installation

Clone this repository and copy its contents to one of the following directories:

### Windows Install

- Windows Powershell

```txt
$HOME\Documents\WindowsPowershell\Modules\
```

- PowerShell v7.0+ (Standalone)

```txt
$HOME\Documents\PowerShell\Modules\
```

### Linux/MacOS Install

```txt
$HOME/.local/share/powershell/Modules/
```

### Import

After installing the modules, you have to register them.
To register these modules, run the following commands
in PowerShell for each module:

```txt
PS > Import-Module Utils
PS > Import-Module PackingUtils
PS > Import-Module SteamUtils
PS > Import-Module PythonUtils
```

Register only those modules you install. No versioning is present in these modules.

## Usage

Refer to readme files of each module to learn how to use cmdlets in such module. Each cmdlet has an alias available as well, in order to make their usage in command line easier. However, to use them in scripts, use the full verb-noun format and optionally the full parameter usage (in other words, do not use positional arguments).

### Utils module

This module defines standalone cmdlets that don't belong to any specific module and don't require any additional software to run.

**List of cmdlets in this module:

- `Compare-FileHash` (alias `cfhash`): Compares a file hash with a given hash string.
- `Compare-BulkFileHash` (alias `cbhash`): Compares bulk hashes of files in your current directory against a specified file containing hashes for each file.
- `Compare-BulkHashResults` (alias `cbhashres`): Extracts information from bulk hash results based on the requested result.

### PackingUtils

This module contains packing utility cmdlets that use various packing software, such as 7-Zip. To use these cmdlets, make sure to install required dependencies. Some cmdlets may give you options you may choose from. If a dependency is optional, it may be ommited entirely.

Cmdlets in this module:

- `Build-MinecraftJavaPack` (alias `buildmcpack`): Builds a Minecraft Java Edition resource or data pack for your server.

#### Current PackinUtils dependencies

Current dependencies for this module are as follows:

- **7-Zip** (command line tool `7z` in your `$env:PATH`)

### SteamUtils

This module contains utilities that utilize the Steam CLI (Command Line Interface). In order to use this module, you do need to have Steam CLI installed in your server. The Steam CLI executable is called `steamcmd` and it needs to be in your `$env:PATH` in order to be used by this module.

Cmdlets in this module are as follows:

- `Publish-SteamWorkshopItem` (aliases `pwsitem`, and `pstwsi`): Publishes a specified Steam Workshop item into the Steam Workshop.

#### SteamUtils Dependency

- **Steam CLI** (command line tool `steamcmd` in your `$env:PATH`)

### PythonUtils

This module may seem unnecessary for you, but it's surprisingly useful in case you're forgetful and often forget how to do certain Python server commands like me. The prime example is the simple HTTP server that's built in to Python.

#### Cmdlets in this module

- `Start-PythonWebserver` (aliases `serve`, and `startwebserver`): Starts a simple Python HTTP server using a specified root location.

#### PythonUtils Dependency

- **Python**: Make sure that the Python executables are available in your `$env:PATH`.

## TODO: Things to finish

- Finish the **Utils** module readme
- Separate the cmdlets dependent on 3rd-party software
