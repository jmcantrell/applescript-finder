on get_required(_prompt, _default)
    set _prefix to ""
    set _icon to note
    repeat
        tell application "Finder" to display dialog _prefix & _prompt default answer _default with icon _icon
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

on get_input(_prompt, _default)
    tell application "Finder" to display dialog _prompt default answer _default with icon note
    return text returned of result
end get_required

on paths_to_files(_paths)
    set _files to {}
    repeat with _path in _paths
        set end of _files to POSIX file _path
    end repeat
    return _files
end paths_to_files

on quote_paths(_files)
    set _paths to ""
    repeat with _file in _files
        set _paths to _paths & " " & quoted form of (POSIX path of (_file as alias))
    end repeat
    return _paths
end quote_paths

on rename_sub(_files)

    if count of _files equals 0 then return

    tell application "Finder"
        display dialog "Are you sure you want to rename these " & (count of _files) & " files?" with icon caution

        set _command to "rename-sub"

        set _pattern to my get_required("Enter pattern:", "")
        set _replace to my get_input("Enter replacement:", "")

        set _command to _command & " -P " & quoted form of _pattern
        set _command to _command & " -R " & quoted form of _replace

        set _command to _command & " " & my quote_paths(_files)

        reveal my paths_to_files(paragraphs of (do shell script _command))
    end tell

end rename_sub

on open (_files)
    rename_sub(_files)
end open

on run
    tell application "Finder" to set _files to selection
    rename_sub(_files)
end run
