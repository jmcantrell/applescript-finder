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

on get_file(_folder, _prompt)
    if _prompt is "" then set _prompt to "Choose a filename:"
    set _names to (name of every file of _folder)
    set _name to first item of (choose from list _names with prompt _prompt)
    if _name is false then return false
    return file _name of _folder
end get_file

on get_filename(_prompt, _default)
    if _prompt is "" then set _prompt to "Enter filename:"
    set _name to my get_required(_prompt, _default)
    tell application "Finder"
        set _folder to (POSIX path of (folder of front window as alias))
    end tell
    set _filename to _folder & _name
end get_filename

on run
    tell application "Finder"

        set templates_folder to (folder "templates" of folder "Code" of folder "Documents" of home)

        set _template to my get_file(templates_folder, "Choose a template:")
        if _template is false then return

        set _filename to my get_filename("Enter filename:", name of _template)
        if _filename is false then return

        set _command to "temple"
        set _command to _command & " -f " & quoted form of (POSIX path of (_template as alias))
        set _command to _command & " " & quoted form of _filename

        do shell script _command

    end tell
end run
