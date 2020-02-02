#!/bin/bash
clear
Plist="Library/LaunchAgents/SleepOnLowBattery.plist"
SoundPlist="Library/LaunchAgents/SleepOnLowBatterySound.plist"
Script="/etc/SleepOnLowBattery.scpt"
SoundScript="/etc/SleepOnLowBatterySound.scpt"

#===============================================================================##
## USER ABORTS SCRIPT #
##==============================================================================##
function _clean_up() {
  printf "User aborted!"
  clear
}

#===============================================================================##
## START #
##==============================================================================##
function main()
{
echo "Uninstalling.."
echo

if test -e $Plist; then launchctl stop SleepOnLowBattery && launchctl unload $Plist && rm -R $Plist; fi
if test -e $SoundPlist; then launchctl stop SleepOnLowBatterySound && launchctl unload $SoundPlist && rm -R $SoundPlist; fi

if test -e $Script; then rm -R $Script; fi
if test -e $SoundScript; then rm -R $SoundScript; fi

echo "..done!"
echo
}

trap '{ _clean_up; exit 1; }' INT

if [[ `id -u` -ne 0 ]];
  then
    echo "This script must be run as ROOT!"
    sudo "$0"
  else
    main
fi

#===============================================================================##
## EOF #
##==============================================================================##