-- Apple Script (i.e. Use in Apple's Script Editor Application) to Toggle Function Keys / Media keys on/off
-- Tested on MacOS Sonoma (14.2.1) Jan 2024, MacOS Monterey (12.6.2) July 2023, MacOS Ventura (13.4.1) July 2023
-- Project Path: https://github.com/MrSimonC/Toggle-Mac-Function-Keys

set osver to system version of (system info)

if osver ≥ 13.0 then
	open location "x-apple.systempreferences:com.apple.Keyboard-Settings.extension"
	
	if osver ≥ 14.0 then
		tell application "System Settings"
			reveal anchor "ModifierKeys" of pane id "com.apple.Keyboard-Settings.extension"
		end tell
	else
		-- it's possible the 'reveal anchor "FunctionKeys"' also works with version 13.0 (MacOS Ventura) but I won't remove the below confirmed-working-code until someone can test that theory.
		tell application "System Events" to tell process "System Settings"
			# example window title: "Keyboard – ￼86%", so "begins with" is needed
			repeat until window begins with "Keyboard" exists
			end repeat
			
			# wait until Keyboard window is the main window of the application and is accessible
			repeat until exists of (1st window whose value of attribute "AXMain" is true)
			end repeat
			
			# wait until the group is displayed (needed else fails on Apple M2 Pro)
			repeat until exists group 1 of group 2 of splitter group 1 of group 1 of window 1
			end repeat
			
			# "Keyboard Shortcuts..." Button (which is button 3 for some macs, and button 1 for others due to keyboard brightness button)
			set keyboardButton to 3
			try
				click button keyboardButton of group 2 of scroll area 1 of group 1 of group 2 of splitter group 1 of group 1 of window 1
			on error errorMessage number errorNumber
				-- 1719 being a "reference error" code
				if errorNumber is -1719 then
					set keyboardButton to 1
					click button keyboardButton of group 2 of scroll area 1 of group 1 of group 2 of splitter group 1 of group 1 of window 1
				end if
			end try
			
			repeat until sheet 1 of window 1 exists
			end repeat
			
			# Click Function Keys
			keystroke "f"
		end tell
	end if
	
	tell application "System Events" to tell process "System Settings"
		repeat until pop up button "Select keyboard" of group 1 of scroll area 1 of group 2 of splitter group 1 of group 1 of sheet 1 of window 1 exists
		end repeat
		
		# Select keyboard: pop up button
		click pop up button "Select keyboard" of group 1 of scroll area 1 of group 2 of splitter group 1 of group 1 of sheet 1 of window 1
		
		# Put the keyboard name
		click menu item "Apple Internal Keyboard / Trackpad" of menu 1 of pop up button "Select keyboard" of group 1 of scroll area 1 of group 2 of splitter group 1 of group 1 of sheet 1 of window 1
		delay 0.5
		
		# Change Option key
		click pop up button 3 of group 2 of scroll area 1 of group 2 of splitter group 1 of group 1 of sheet 1 of window 1
		if value of pop up button 3 of group 2 of scroll area 1 of group 2 of splitter group 1 of group 1 of sheet 1 of window 1 as text is "⌥ Option" then
			click menu item "⌘ Command" of menu 1 of pop up button 3 of group 2 of scroll area 1 of group 2 of splitter group 1 of group 1 of sheet 1 of window 1
		else
			click menu item "⌥ Option" of menu 1 of pop up button 3 of group 2 of scroll area 1 of group 2 of splitter group 1 of group 1 of sheet 1 of window 1
		end if
		delay 0.5
		
		click pop up button 4 of group 2 of scroll area 1 of group 2 of splitter group 1 of group 1 of sheet 1 of window 1
		if value of pop up button 4 of group 2 of scroll area 1 of group 2 of splitter group 1 of group 1 of sheet 1 of window 1 as text is "⌥ Option" then
			click menu item "⌘ Command" of menu 1 of pop up button 4 of group 2 of scroll area 1 of group 2 of splitter group 1 of group 1 of sheet 1 of window 1
		else
			click menu item "⌥ Option" of menu 1 of pop up button 4 of group 2 of scroll area 1 of group 2 of splitter group 1 of group 1 of sheet 1 of window 1
		end if
		delay 0.5
		
		
		
		# Select keyboard: pop up button
		click pop up button "Select keyboard" of group 1 of scroll area 1 of group 2 of splitter group 1 of group 1 of sheet 1 of window 1
		
		try
			# Put the keyboard name
			click menu item "G915 KEYBOARD" of menu 1 of pop up button "Select keyboard" of group 1 of scroll area 1 of group 2 of splitter group 1 of group 1 of sheet 1 of window 1
			delay 0.5
			
			# Change Option key
			click pop up button 3 of group 2 of scroll area 1 of group 2 of splitter group 1 of group 1 of sheet 1 of window 1
			if value of pop up button 3 of group 2 of scroll area 1 of group 2 of splitter group 1 of group 1 of sheet 1 of window 1 as text is "⌥ Option" then
				click menu item "⌘ Command" of menu 1 of pop up button 3 of group 2 of scroll area 1 of group 2 of splitter group 1 of group 1 of sheet 1 of window 1
			else
				click menu item "⌥ Option" of menu 1 of pop up button 3 of group 2 of scroll area 1 of group 2 of splitter group 1 of group 1 of sheet 1 of window 1
			end if
			delay 0.5
			
			click pop up button 4 of group 2 of scroll area 1 of group 2 of splitter group 1 of group 1 of sheet 1 of window 1
			if value of pop up button 4 of group 2 of scroll area 1 of group 2 of splitter group 1 of group 1 of sheet 1 of window 1 as text is "⌥ Option" then
				click menu item "⌘ Command" of menu 1 of pop up button 4 of group 2 of scroll area 1 of group 2 of splitter group 1 of group 1 of sheet 1 of window 1
			else
				click menu item "⌥ Option" of menu 1 of pop up button 4 of group 2 of scroll area 1 of group 2 of splitter group 1 of group 1 of sheet 1 of window 1
			end if
			delay 0.5
		on error
			# display dialog "Keyboard not found. Please select a different keyboard."
		end try
		
		
		
		# "Done" Button - Close the sheet so the application can quit
		click button 2 of group 2 of splitter group 1 of group 1 of sheet 1 of window 1
		
		# Attempting to check the sheet at a certain point while closing will throw an error
		# In that case, the outer repeat will try again
		repeat
			try
				repeat while sheet 1 of window 1 exists
				end repeat
				exit repeat
			end try
		end repeat
	end tell
	
	tell application "System Settings" to quit
else if osver < 13.0 then
	-- Below for MacOS Monterey and below
	tell application "System Settings"
		set current pane to pane "com.apple.preference.keyboard"
	end tell
	
	tell application "System Events"
		if UI elements enabled then
			tell application process "System Preferences"
				repeat until exists tab group 1 of window "Keyboard"
					delay 0.5
				end repeat
				click radio button "Keyboard" of tab group 1 of window "Keyboard"
				try
					click checkbox "Use F1, F2, etc. keys as standard function keys on external keyboards" of tab group 1 of window "Keyboard"
				end try
				try
					click checkbox "Use F1, F2, etc. keys as standard function keys" of tab group 1 of window "Keyboard"
				end try
			end tell
			tell application "System Settings" to quit
		else
			-- GUI scripting not enabled.  Display an alert
			tell application "System Settings"
				activate
				set current pane to pane "com.apple.preference.security"
				display dialog "UI element scripting is not enabled. Please activate this app under Privacy -> Accessibility so it can access the settings it needs."
			end tell
		end if
	end tell
end if
