on run
    tell application "Finder"
        try
            set theFolder to (folder of the front window as alias)
        on error
            set theFolder to (path to desktop folder as alias)
        end try
    end tell
    open_in_terminal(theFolder)
end run

on is_app_running(appName)
    tell application "System Events" to (name of processes) contains appName
end is_app_running

on open_in_terminal(theFolder)
    set wasRunning to is_app_running("Terminal")
    tell application "Terminal"
        activate
        if wasRunning then
            tell application "System Events" to tell process "Terminal" to keystroke "t" using command down
        end if
        do script with command "cd " & quoted form of POSIX path of theFolder in window 1
    end tell
end open_in_terminal

