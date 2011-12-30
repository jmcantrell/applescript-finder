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

on rename_case(_files)

    if (count of _files) is equal to 0 then return

    tell application "Finder"
        display dialog "Are you sure you want to rename these " & (count of _files) & " files?" with icon caution

        set _command to "rename-manual " & my quote_paths(_files)

        reveal my paths_to_files(paragraphs of (do shell script _command))
    end tell

end rename_case

on open (_files)
    rename_case(_files)
end open

on run
    tell application "Finder" to set _files to selection
    rename_case(_files)
end run
