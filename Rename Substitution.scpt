on getRequiredInput(promptText, defaultValue)
    set promptPrefix to ""
    set promptIcon to note
    repeat
        tell application "Finder" to display dialog promptPrefix & promptText default answer defaultValue with icon promptIcon
        set replyValue to text returned of result
        try
            if replyValue = "" then error
            exit repeat
        on error
            set promptPrefix to "INVALID ENTRY! "
            set promptIcon to stop
        end try
    end repeat
    return replyValue
end

on getInput(promptText, defaultValue)
    tell application "Finder" to display dialog promptText default answer defaultValue with icon note
    return text returned of result
end

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

        set renameCommand to "rename-sub"

        set pattern to my getRequiredInput("Enter pattern:", "")
        set replacement to my getInput("Enter replacement:", "")

        set renameCommand to renameCommand & " -P " & quoted form of pattern
        set renameCommand to renameCommand & " -R " & quoted form of replacement

        set renameCommand to renameCommand & " " & my quotePathes(theFiles)

        reveal my pathsToFiles(paragraphs of (do shell script renameCommand))
    end tell

end

on open (theFiles)
    renameFiles(theFiles)
end

on run
    tell application "Finder" to set theFiles to selection
    renameFiles(theFiles)
end
