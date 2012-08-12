on run
    tell application "Finder" to set selectedFiles to selection as alias list
    tell application "Preview"
        activate
        open selectedFiles
    end tell
end run
