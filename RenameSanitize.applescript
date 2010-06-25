on run
    tell application "Finder" to set inputFiles to selection
    rename_sanitize(inputFiles)
end run

on open (inputFiles)
    rename_sanitize(inputFiles)
end open

on rename_sanitize(inputFiles)

    set lengthFiles to length of inputFiles

    if lengthFiles equals 0 then return

    tell application "Finder"

        --Only rename files
        repeat with inputFile in inputFiles
            if the URL of inputFile ends with "/" then return
        end repeat

        display dialog "Are you sure you want to rename these " & lengthFiles & " files?" with icon caution

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
            set end of renamedFiles to (my POSIX file renamedFilename)
        end repeat

        --Select the files that were acted on
        reveal renamedFiles

    end tell

end rename_sanitize
