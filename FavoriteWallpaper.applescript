on run
    tell application "Finder" to set theFiles to selection
    set_favorites(theFiles)
end run

on drop(theFiles)
    set_favorites(theFiles)
end drop

on set_favorites(theFiles)
    display dialog "Are you sure you want to add these " & (length of theFiles) & " wallpapers?" with icon caution
    tell application "Finder"
        set picsFolder to folder "Pictures" of home
        if not (exists folder "Wallpapers" of picsFolder) then
            make new folder at picsFolder with properties {name:"Wallpapers"}
        end if
        set favsFolder to folder "Wallpapers" of picsFolder
        repeat with theFile in theFiles
            if kind of theFile ends with " image" then
                make new alias file at favsFolder to theFile
            end if
        end repeat
    end tell
end set_favorites
