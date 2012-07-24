on pathsToFiles(thePaths)
    set theFiles to {}
    repeat with thePath in thePaths
        set end of theFiles to POSIX file thePath
    end repeat
    return theFiles
end

on quotePaths(theFiles)
    set thePaths to ""
    repeat with theFile in theFiles
        set thePaths to thePaths & " " & quoted form of (POSIX path of (theFile as alias))
    end repeat
    return thePaths
end

on renameFiles(theFiles)

    if count of theFiles equals 0 then return

    tell application "Finder"
        display dialog "Are you sure you want to rename these " & (count of theFiles) & " files?" with icon caution

        set renameCommand to "rename-sanitize " & my quotePaths(theFiles)

        set newFiles to paragraphs of (do shell script renameCommand)

        reveal my pathsToFiles(newFiles)
    end tell

end

on open (theFiles)
    renameFiles(theFiles)
end

on run
    tell application "Finder" to set theFiles to selection
    renameFiles(theFiles)
end
