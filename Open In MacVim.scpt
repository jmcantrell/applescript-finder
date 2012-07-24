on openInMacvim(theFiles)
    set openCommand to "mvim"
    repeat with theFile in theFiles
        set openCommand to openCommand & " " & quoted form of (POSIX path of theFile)
    end repeat
    do shell script openCommand
end

on run
    tell application "Finder" to set theFiles to selection as alias list
    openInMacvim(theFiles)
end

on open(theFiles)
	openInMacvim(theFiles)
end
