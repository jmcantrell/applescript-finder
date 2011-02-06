on paths_to_files(_paths)
    set _files to {}
    repeat with _path in _paths
        set end of _files to POSIX file _path
    end repeat
    return _files
end paths_to_files

on rename_sanitize(_files)

    if count of _files equals 0 then return

    tell application "Finder"
        display dialog "Are you sure you want to rename these " & (count of _files) & " files?" with icon caution

        set _command to "rename-sanitize"

        repeat with _file in _files
            set _command to _command & " " & quoted form of (POSIX path of (_file as alias))
        end repeat

        set _new_files to paragraphs of (do shell script _command)

        reveal my paths_to_files(_new_files)
    end tell

end rename_sanitize

on open (_files)
    rename_sanitize(_files)
end open

on run
    tell application "Finder" to set _files to selection
    rename_sanitize(_files)
end run
