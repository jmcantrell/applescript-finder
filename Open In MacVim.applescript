on run
    tell application "Finder" to set inputFiles to selection
    open_in_macvim(inputFiles)
end run

on open(inputFiles)
    open_in_macvim(inputFiles)
end open

on open_in_macvim(inputFiles)
    if length of inputFiles equals 0 then return
    tell application "MacVim"
        open inputFiles
    end tell
end open_in_macvim
