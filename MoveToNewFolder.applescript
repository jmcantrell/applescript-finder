on run
    tell application "Finder" to set theFiles to selection
    move_to_folder(theFiles)
end run

on open(theFiles)
    move_to_folder(theFiles)
end open

on get_required(thePrompt, theDefault)
    set thePrefix to ""
    set theIcon to note
    repeat
        display dialog thePrefix & thePrompt default answer theDefault with icon theIcon
        set theReply to text returned of result
        try
            if theReply = "" then error
            exit repeat
        on error
            set thePrefix to "INVALID ENTRY! "
            set theIcon to stop
        end try
    end repeat
    return theReply
end get_required

on move_to_folder(theFiles)
    if length of theFiles is equal to 0 then return
    set folderName to my get_required("Enter folder name:", "")
    tell application "Finder"
        set baseFolder to folder of the front window
        if not (exists folder folderName of baseFolder) then
            make new folder at baseFolder with properties {name:folderName}
        end if
        set theFolder to folder folderName of baseFolder
        repeat with theFile in theFiles
            move theFile to theFolder
        end repeat
        reveal theFolder
    end tell
end move_to_folder
