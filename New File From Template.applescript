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

on getFile(theFolder, promptText)
    if promptText is "" then set promptText to "Choose a filename:"
    set theNames to (name of every file of theFolder)
    set theName to first item of (choose from list theNames with prompt promptText)
    if theName is false then return false
    return file theName of theFolder
end

on getFilenameInput(promptText, defaultValue)
    if promptText is "" then set promptText to "Enter filename:"
    set theName to my getRequiredInput(promptText, defaultValue)
    tell application "Finder"
        set theFolder to (POSIX path of (folder of front window as alias))
    end tell
    set theFilename to theFolder & theName
end

on run
    tell application "Finder"

        set templateFolder to (folder "Templates" of folder "templates" of folder "Code" of home)

        set templateFile to my getFile(templateFolder, "Choose a template:")
        if templateFile is false then return

        set theFilename to my getFilenameInput("Enter filename:", name of templateFile)
        if theFilename is false then return

        set homeFolder to POSIX path of (path to home folder) as string
        set renameCommand to homeFolder & ".local/bin/temple"
        set renameCommand to renameCommand & " -f " & quoted form of (POSIX path of (templateFile as alias))
        set renameCommand to renameCommand & " " & quoted form of theFilename

        do shell script renameCommand

        activate

        reveal my POSIX file theFilename

    end tell
end
