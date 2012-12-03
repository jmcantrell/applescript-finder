on isRunning(appName)
    tell application "System Events" to (name of processes) contains appName
end

on openInIterm(theFolder)
    set wasRunning to isRunning("iTerm")
    tell application "iTerm"
        activate
        tell the first terminal
            if wasRunning then
                launch session "Default Session"
            end if
            tell the last session
                write text "cd " & quoted form of POSIX path of theFolder
            end tell
        end tell
    end tell
end

on run
    tell application "Finder"
        try
            set theFolder to (folder of the front window as alias)
        on error
            set theFolder to (path to desktop folder as alias)
        end try
    end tell
    openInIterm(theFolder)
end
