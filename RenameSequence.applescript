on run
    tell application "Finder" to set inputFiles to selection
    rename_sequence(inputFiles)
end run

on open (inputFiles)
    rename_sequence(inputFiles)
end open

on get_number(thePrompt, theDefault)
    set thePrefix to ""
    set theIcon to note
    repeat
        display dialog thePrefix & thePrompt default answer theDefault with icon theIcon
        set theNumber to text returned of result
        try
            if theNumber = "" then error
            set theNumber to theNumber as number
            exit repeat
        on error
            set thePrefix to "INVALID ENTRY! "
            set theIcon to stop
        end try
    end repeat
    return theNumber
end get_number

on rename_sequence(inputFiles)

    set lengthFiles to length of inputFiles

    if lengthFiles equals 0 then return

    tell application "Finder"

        --Only rename files
        repeat with inputFile in inputFiles
            if the URL of inputFile ends with "/" then return
        end repeat

        display dialog "Are you sure you want to rename these " & lengthFiles & " files?" with icon caution

        set homePath to the POSIX path of (get path to home folder)
        set renameCommand to "/usr/local/bin/python " & homePath & ".local/bin/rename-sequence"

        get_number("Enter start number:", 1) of me
        set theStart to result as number

        set thePrefix to (display dialog "Enter prefix:" default answer "" with icon note)
        set theSuffix to (display dialog "Enter suffix:" default answer "" with icon note)

        get_number("Enter sequence width (0 = auto):", 0)
        set theWidth to result as number

        set renameCommand to renameCommand & " -s " & theStart
        set renameCommand to renameCommand & " -w " & theWidth
        set renameCommand to renameCommand & " -P " & quoted form of thePrefix
        set renameCommand to renameCommand & " -S " & quoted form of theSuffix

        --Build command arguments with properly quoted filenames
        repeat with inputFile in inputFiles
            set renameCommand to renameCommand & " " & quoted form of POSIX path of inputFile
        end repeat

        --Command outputs filenames (one per line)
        set renamedFilenames to paragraphs of (do shell script renameCommand)

        --Convert filenames to file objects
        set renamedFiles to {}
        repeat with renamedFilename in renamedFilenames
            set end of renamedFiles to (my POSIX file renamedFilename)
        end repeat

        --Select the files that were acted on
        reveal renamedFiles

    end tell

end rename_sequence

