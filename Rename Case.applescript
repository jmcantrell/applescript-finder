on regularFiles(theFiles)
    set newFiles to {}
    tell application "Finder"
        repeat with theFile in theFiles
            if the URL of theFile does not end with "/" then
                set end of newFiles to theFile
            end if
        end repeat
    end tell
    return newFiles
end regularFiles

on pathsToFiles(thePaths)
    set theFiles to {}
    repeat with thePath in thePaths
        set end of theFiles to POSIX file thePath
    end repeat
    return theFiles
end pathsToFiles

on quotePaths(theFiles)
    set thePaths to ""
    repeat with theFile in theFiles
        set thePaths to thePaths & " " & quoted form of (POSIX path of (theFile as alias))
    end repeat
    return thePaths
end quotePaths

on renameFiles(theFiles)

    set theFiles to regularFiles(theFiles)
    if (count of theFiles) is equal to 0 then return

    tell application "Finder"
        display dialog "Are you sure you want to rename these " & (count of theFiles) & " files?" with icon caution

        set homeFolder to POSIX path of (path to home folder) as string
        set renameCommand to homeFolder & ".local/bin/rename-case"

        set availableCases to paragraphs of (do shell script renameCommand & " -L")

        set theCase to (choose from list availableCases with prompt "Choose case:")
        if theCase is false then return

        set renameCommand to renameCommand & " -C " & theCase

        set renameCommand to renameCommand & " " & my quotePaths(theFiles)

        reveal my pathsToFiles(paragraphs of (do shell script renameCommand))
    end tell

end renameFiles

on open (selectedFiles)
    renameFiles(selectedFiles)
end open

on run
    tell application "Finder" to set selectedFiles to selection
    renameFiles(selectedFiles)
end run
