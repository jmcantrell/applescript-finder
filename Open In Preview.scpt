on run
    tell application "Finder" to set selectedFiles to selection as alias list
    tell application "Preview" to open selectedFiles
end

