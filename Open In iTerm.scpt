on is_running(_app_name)
    tell application "System Events" to (name of processes) contains _app_name
end is_running

on open_in_iterm(_folder)
    set _was_running to is_running("iTerm")
    tell application "iTerm"
        activate
        tell the first terminal
            if _was_running then
                launch session "Default Session"
            end if
            tell the last session
                write text "cd " & quoted form of POSIX path of _folder
            end tell
        end tell
    end tell
end open_in_iterm

on run
    tell application "Finder"
        try
            set _folder to (folder of the front window as alias)
        on error
            set _folder to (path to desktop folder as alias)
        end try
    end tell
    open_in_iterm(_folder)
end run
