<#
	.SYNOPSIS
		Creates redundant, renamed duplicates of everything in a directory.

	.DESCRIPTION
		A specialized Windows PowerShell script written for version 5.0. This will create two copies of ALL of the documents in a directory into a subdirectory named "Dupes", and the names will be changed to STU[x].[y] and STU[x]-ASSESS.[y] where [x] is the counter number and [y] is the file extension.
        Script Version 3

	.NOTES
		Author: Sean Batzel
		Requires: PowerShell 5.0
		Make sure you run 
		"Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope Process" (no quotes)
		before trying to run this script. Otherwise, it won't run.
        Version 1 will duplicate EVERY FILE in the working directory INCLUDING the Dupes directory that it creates and itself.
        Version 2 fixed the errors in Version 1.
        Version 3 fixes the file naming to match the requested files.
#>

# Initialize the counter variable - note, the variable ALWAYS begins with a $.
$x = 1

# Create a new directory with the name "Dupes"
New-Item -Type Directory -Name Dupes

# Recursively get the contents of the directory and pipe it into a foreach loop. The | is a pipeline.
Get-ChildItem | ForEach-Object {

    # First we check if the current object is a Directory or a .ps1 file.
    if (( -not ($_ -is [System.IO.DirectoryInfo])) -and $_.Extension -ne ".ps1"){
    
	    # Get the file's extension and save it as a variable.
	    $extension = $_.Extension

	    # Create the two new filenames.
	    $newname = "STU" + $x + "-POST" + $extension
	    $nexname = "STU" + $x + "-ASSESS-POST" + $extension

	    # $_ just means "the current object in the foreach loop"
	    # This cmdlet copies the file twice into Dupes, one under each name.
	    Copy-Item $_ -Destination Dupes\$newname
	    Copy-Item $_ -Destination Dupes\$nexname

	    # Increment the counter.
	    $x++    
    }
}