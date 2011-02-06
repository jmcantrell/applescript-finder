on get_required(_prompt, _default)
    set _prefix to ""
    set _icon to note
    repeat
        display dialog _prefix & _prompt default answer _default with icon _icon
        set _reply to text returned of result
        try
            if _reply = "" then error
            exit repeat
        on error
            set _prefix to "INVALID ENTRY! "
            set _icon to stop
        end try
    end repeat
    return _reply
end get_required

on get_filename(_prompt, _default)
    if _prompt is "" then set _prompt to "Enter filename:"
    set _name to my get_required(_prompt, _default)
    tell application "Finder"
        set _folder to (POSIX path of (folder of front window as alias))
    end tell
    set _filename to _folder & _name
end get_filename

on move_to_folder(_files)

    if (count of _files) is equal to 0 then return

    set _folder to get_filename("Enter folder name:", "New Folder")
    if _folder is false then return

    do shell script "mkdir -p " & quoted form of _folder

    repeat with _file in _files
        do shell script "mv " & quoted form of (POSIX path of (_file as alias)) & " " & quoted form of _folder
    end repeat

end move_to_folder

on open (_files)
    move_to_folder(_files)
end open

on run
    tell application "Finder" to set _files to selection
    move_to_folder(_files)
end run
