#!/bin/bash
clear
Plist="Library/LaunchAgents/SleepOnLowBattery.plist"
SoundPlist="Library/LaunchAgents/SleepOnLowBatterySound.plist"

echo "Uninstalling. If asked, simply press ENTER now on your keyboard:"
echo
launchctl stop SleepOnLowBattery
launchctl stop SleepOnLowBatterySound

if test -e $Plist; then launchctl unload SleepOnLowBattery && rm -R $Plist; fi
if test -e $SoundPlist; then launchctl unload SleepOnLowBatterySound && rm -R $SoundPlist; fi
echo
echo "..done!"
echo
echo "Most likely you need to restart for the script to become inactive!"
echo