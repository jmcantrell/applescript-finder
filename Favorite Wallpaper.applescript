on run
    tell application "Finder" to set theFiles to selection
    set_favorites(theFiles)
end run

on open(theFiles)
    set_favorites(theFiles)
end open

on set_favorites(theFiles)
    display dialog "Are you sure you want to add these " & (length of theFiles) & " wallpapers?" with icon caution
    tell application "Finder"
        set picsFolder to folder "Dropbox" of folder "Documents" of home
        if not (exists folder "Wallpapers" of picsFolder) then
            make new folder at picsFolder with properties {name:"Wallpapers"}
        end if
        set favsFolder to folder "Wallpapers" of picsFolder
        repeat with theFile in theFiles
            if kind of theFile ends with " image" then
                duplicate theFile to favsFolder
            end if
        end repeat
    end tell
end set_favorites
