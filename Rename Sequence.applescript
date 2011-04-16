on paths_to_files(_paths)
    set _files to {}
    repeat with _path in _paths
        set end of _files to POSIX file _path
    end repeat
    return _files
end paths_to_files

on get_number(_prompt, _default)
    if _prompt = "" then set _prompt to "Enter number:"
    set _prefix to ""
    set _icon to note
    repeat
        display dialog _prefix & _prompt default answer _default with icon _icon
        set _number to text returned of result
        try
            if _number = "" then error
            set _number to _number as number
            exit repeat
        on error
            set _prefix to "INVALID ENTRY! "
            set _icon to stop
        end try
    end repeat
    return _number
end get_number

on rename_seq(_files)

    if count of _files equals 0 then return

    tell application "Finder"
        display dialog "Are you sure you want to rename these " & (count of _files) & " files?" with icon caution

        set _command to "rename-seq"

        set _start to my get_number("Enter start number:", 1)
        set _prefix to (display dialog "Enter prefix:" default answer "" with icon note)
        set _suffix to (display dialog "Enter suffix:" default answer "" with icon note)
        set _width to my get_number("Enter sequence width (0 = auto):", 0)

        set _command to _command & " -s " & _start
        set _command to _command & " -w " & _width
        set _command to _command & " -P " & quoted form of _prefix
        set _command to _command & " -S " & quoted form of _suffix

        repeat with _file in _files
            set _command to _command & " " & quoted form of (POSIX path of (_file as alias))
        end repeat

        reveal my paths_to_files(paragraphs of (do shell script _command))
    end tell

end rename_seq

on open (_files)
    rename_seq(_files)
end open

on run
    tell application "Finder" to set _files to selection
    rename_seq(_files)
end run
