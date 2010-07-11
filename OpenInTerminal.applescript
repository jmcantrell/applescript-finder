on run
    tell application "Finder"
        try
            set theFolder to (folder of the front window as alias)
        on error
            set theFolder to (path to desktop folder as alias)
        end try
    end tell
    open_in_iterm(theFolder)
end run

on is_app_running(appName)
    tell application "System Events" to (name of processes) contains appName
end is_app_running

on open_in_iterm(theFolder)
    set wasRunning to my is_app_running("iTerm")
    tell application "iTerm"
        activate
        tell the first terminal
            if wasRunning then launch session "Default Session"
            tell the last session
                write text "cd " & quoted form of POSIX path of theFolder
            end tell
        end tell
    end tell
end open_in_iterm
