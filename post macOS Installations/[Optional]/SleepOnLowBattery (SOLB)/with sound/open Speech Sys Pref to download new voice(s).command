#!/bin/bash
clear

cd "$(dirname "$0")"
osascript "Extras/download new voice(s).scpt"

osascript -e 'tell app "Terminal"' -e 'close (every window whose name contains ".command")' -e 'if number of windows = 0 then quit' -e 'end tell' & exit;
