on run
    tell application "Finder" to set inputFiles to selection as alias list
    open_in_macvim(inputFiles)
end run

on open_in_macvim(inputFiles)
    if length of inputFiles is equal to 0 then return
    tell application "MacVim"
        open inputFiles
    end tell
end open_in_macvim
