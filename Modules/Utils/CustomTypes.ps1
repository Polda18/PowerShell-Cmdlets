# Custom Types for Utils module
# This file defines custom types used in the Utils module
#---------------------------------------------------------------------------------------

# Define a custom type to represent the result of a hash comparison
class CompareHashResult {
    [string]$Path       # The file path being compared
    [string]$Result     # The result of the comparison, expected to be "OK" or "FAILED"
}

# Add new types here as needed, and ensure they are added to the $ExportableTypes array
# at the end of this file to be exported when the module is imported.

# Types exported by this module
#--------------------------------------------------------------------------------------

# Define the types to be exported when the module is imported
$ExportableTypes = @(
    [CompareHashResult]
    # Add new types in this array to have them exported when the module is imported.
)

# Get the internal TypeAccelerator class to use its static methods
$TypeAcceleratorClass = [PSOBject].Assembly.GetType("System.Management.Automation.TypeAccelerators")

# Ensure none of the types would clobber an existing type accelerator.
# If a type accelerator with the same name exists, throw an exception.
$ExistingTypeAccelerators = $TypeAcceleratorClass::Get
foreach ($Type in $ExportableTypes) {
    if ($Type.FullName -in $ExistingTypeAccelerators.Keys) {
        $Message = @(
            "Unable to register type accelerator '$($Type.FullName)'"
            'Accelerator already exists.'
        ) -join ' - '

        throw [System.Management.Automation.ErrorRecord]::new(
            [System.InvalidOperationException]::new($Message),
            'TypeAcceleratorAlreadyExists',
            [System.Management.Automation.ErrorCategory]::InvalidOperation,
            $Type.FullName
        )
    }
}
# Add type accelerators for every exportable type.
foreach ($Type in $ExportableTypes) {
    $TypeAcceleratorsClass::Add($Type.FullName, $Type)
}
# Remove type accelerators when the module is removed.
$MyInvocation.MyCommand.ScriptBlock.Module.OnRemove = {
    foreach($Type in $ExportableTypes) {
        $TypeAcceleratorsClass::Remove($Type.FullName)
    }
}.GetNewClosure()
