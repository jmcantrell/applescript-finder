on is_running(_app_name)
    tell application "System Events" to (name of processes) contains _app_name
end is_running

on open_in_terminal(_folder)
    set _was_running to is_running("Terminal")
    tell application "Terminal"
        activate
        if _was_running then
            tell application "System Events"
                tell process "Terminal" to keystroke "t" using command down
            end tell
        end if
        do script with command "cd " & quoted form of POSIX path of _folder in window 1
    end tell
end open_in_terminal

on run
    tell application "Finder"
        try
            set _folder to (folder of the front window as alias)
        on error
            set _folder to (path to desktop folder as alias)
        end try
    end tell
    open_in_terminal(_folder)
end run
