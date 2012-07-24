on pathsToFiles(thePaths)
    set theFiles to {}
    repeat with thePath in thePaths
        set end of theFiles to POSIX file thePath
    end repeat
    return theFiles
end

on getInput(promptText, defaultValue)
    tell application "Finder" to display dialog promptText default answer defaultValue with icon note
    return text returned of result
end

on getNumberInput(promptText, defaultValue)
    if promptText = "" then set promptText to "Enter number:"
    set promptPrefix to ""
    set promptIcon to note
    repeat
        display dialog promptPrefix & promptText default answer defaultValue with icon promptIcon
        set numberValue to text returned of result
        try
            if numberValue = "" then error
            set numberValue to numberValue as number
            exit repeat
        on error
            set promptPrefix to "INVALID ENTRY! "
            set promptIcon to stop
        end try
    end repeat
    return numberValue
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

        set renameCommand to "rename-seq"

        set startNumber to my getNumberInput("Enter start number:", 1)
        set prefixText to my getInput("Enter prefix:", "")
        set suffixText to my getInput("Enter suffix:", "")
        set numberWidth to my getNumberInput("Enter sequence width (0 = auto):", 0)

        set renameCommand to renameCommand & " -s " & startNumber
        set renameCommand to renameCommand & " -w " & numberWidth
        set renameCommand to renameCommand & " -P " & quoted form of prefixText
        set renameCommand to renameCommand & " -S " & quoted form of suffixText

        set renameCommand to renameCommand & " " & quotePaths(theFiles)

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
