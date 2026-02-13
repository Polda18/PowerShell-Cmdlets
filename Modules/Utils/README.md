# Standalone Utility Cmdlets

This module contains utility cmdlets that do not require any additional software to run. For full explanation of each cmdlet and its usage refer to the wiki.

## Cmdlet: Compare-FileHash

This cmdlet lets you to compare a file hash with a given hash string. Function returns a custom object that contains the path of the given file and the result of the comparison:

- `Result: OK` for a matching hash
- `Result: FAILED` for a mismatch

This cmdlet has the alias `cfhash` which you can use in command line.

Usage of this cmdlet is as follows:

```txt
PS> Compare-FileHash [-Path] <string>> -ExpectedHash <string> [-Algorithm <MD5|SHA1|SHA256|SHA384|SHA512>]
```

Arguments for this cmdlet:

- `-Path`: This is the path to the file you want to compare. This argument is required, but you can omit the name of the argument, if you place it right after the command.
- `-ExpectedHash`: This is the expected hash you want to compare the file against. This argument is required.
- `-Algorithm`: This is the algorithm to use for the hash comparison. Make sure to select the needed algorithm for the specific hash type you need to compare. This argument is optional, default value is SHA256, which is the standard hashing algorithm for file checksums.

### Example Usage of Compare-FileHash

```txt
PS > Compare-FileHash .\README.md -ExpectedHash CAC4A5B775B9F2A05AC9392D5F2FC51590A0AB2818F1542EFE944DA202ABA18C

Path                                           Result
----                                           ------
D:\GITHUB\Polda18\PowerShell-Cmdlets\README.md OK

PS > Compare-FileHash .\README.md -ExpectedHash 3972DC9744F6499F0F9B2DBF76696F2AE7AD8AF9B23DDE66D6AF86C9DFB36986

Path                                           Result
----                                           ------
D:\GITHUB\Polda18\PowerShell-Cmdlets\README.md FAILED

```

## Cmdlet: Compare-BulkFileHash

- _**TODO:** Add information about the rest of the cmdlets._
