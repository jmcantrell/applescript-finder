on set_favorites(_files)
    tell application "Finder"
        display dialog "Are you sure you want to add these " & (length of _files) & " wallpapers?" with icon caution
        set _folder to folder "Wallpapers" of folder "Dropbox" of home
        repeat with _file in _files
            if kind of _file ends with " image" then
                duplicate _file to _folder
            end if
        end repeat
    end tell
end set_favorites

on open(_files)
    set_favorites(_files)
end open

on run
    tell application "Finder" to set _files to selection
    set_favorites(_files)
end run
