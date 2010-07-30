on run
    tell application "Finder" to set inputFiles to selection as alias list
    tell application "MacVim" to open inputFiles
end run
