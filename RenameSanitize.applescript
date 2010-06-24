on run
    tell application "Finder" to set inputFiles to selection
    rename_sanitize(inputFiles)
end run

on open (inputFiles)
    rename_sanitize(inputFiles)
end open

on rename_sanitize(inputFiles)

    if length of inputFiles equals 0 then return

    tell application "Finder"

        --Only rename files
        repeat with inputFile in inputFiles
            if the URL of inputFile ends with "/" then return
        end repeat

        set homePath to the POSIX path of (get path to home folder)
        set renameCommand to "/usr/local/bin/python " & homePath & ".local/bin/rename-sanitize"

        --Build command arguments with properly quoted filenames
        repeat with inputFile in inputFiles
            set renameCommand to renameCommand & " " & quoted form of POSIX path of inputFile
        end repeat

        --Command outputs filenames (one per line)
        set renamedFilenames to paragraphs of (do shell script renameCommand)

        --Convert filenames to file objects
        set renamedFiles to {}
        repeat with renamedFilename in renamedFilenames
            set end of renamedFiles to POSIX File (renamedFilename)
        end repeat

        --Select the files that were acted on
        activate
        try
            select every item of renamedFiles
        on error errMsg number errNum
            display alert "Could not make selection (" & errNum & "):" message errMsg as critical
            return
        end try
    end tell

end rename_sanitize
