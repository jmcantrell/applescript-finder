on run
    tell application "Finder" to set inputFiles to selection
    rename_sanitize(inputFiles)
end run

on open(inputFiles)
    rename_sanitize(inputFiles)
end open

on rename_sanitize(inputFiles)
    if length of inputFiles equals 0 then return
    tell application "Finder"
        display dialog "Are you sure you want to rename these " & (length of inputFiles) & " files?" with icon caution
        set homePath to the POSIX path of (get path to home folder)
        set renameCommand to "/Library/Frameworks/Python.framework/Versions/Current/bin/python " & homePath & ".local/bin/rename-sanitize"
        repeat with inputFile in inputFiles
            set renameCommand to renameCommand & " " & quoted form of POSIX path of inputFile
        end repeat
        set renamedFilenames to paragraphs of (do shell script renameCommand)
        set renamedFiles to {}
        repeat with renamedFilename in renamedFilenames
            set end of renamedFiles to (my POSIX file renamedFilename)
        end repeat
        reveal renamedFiles
    end tell
end rename_sanitize
