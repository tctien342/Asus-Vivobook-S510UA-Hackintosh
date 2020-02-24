#!/bin/bash
clear

open "x-apple.systempreferences:" && open "x-apple.systempreferences:com.apple.preference.universalaccess?TextToSpeech"

#osascript -e "tell application \"System Preferences\"" -e "set the current pane to pane id \"com.apple.preference.universalaccess\"" -e "reveal anchor \"TextToSpeech\" of pane id \"com.apple.preference.universalaccess\"" -e "activate"  -e "end tell"

osascript -e 'tell app "Terminal"' -e 'close (every window whose name contains ".command")' -e 'if number of windows = 0 then quit' -e 'end tell' & exit;
