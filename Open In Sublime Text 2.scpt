on openInSublime(theFiles)
    tell application "Sublime Text 2"
    	open theFiles
    	activate
    end
end

on run
	tell application "Finder"
		if selection is {} then
			set theSelection to folder of the front window as string
		else
			set theSelection to selection as alias list
		end
	end
    openInSublime(theSelection)
end

on open(theFiles)
	openInSublime(theFiles)
end