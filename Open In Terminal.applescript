on isRunning(appName)
    tell application "System Events" to (name of processes) contains appName
end isRunning

on openInTerminal(theFolder)
    set wasRunning to isRunning("Terminal")
    tell application "Terminal"
        activate
        if wasRunning then
            tell application "System Events"
                tell process "Terminal" to keystroke "t" using command down
            end tell
        end if
        do script with command "cd " & quoted form of POSIX path of theFolder in window 1
    end tell
end openInTerminal

on run
    tell application "Finder"
        try
            set theFolder to (folder of the front window as alias)
        on error
            set theFolder to (path to desktop folder as alias)
        end try
    end tell
    openInTerminal(theFolder)
end run
