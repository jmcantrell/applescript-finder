on run
    tell application "Finder" to set _files to selection as alias list
    set _command to "open -a Preview.app"
    repeat with _file in _files
        set _command to _command & " " & quoted form of (POSIX path of _file)
    end repeat
    do shell script _command
end run
