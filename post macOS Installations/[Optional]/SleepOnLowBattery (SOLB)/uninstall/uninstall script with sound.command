#!/bin/bash
clear

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
launchctl stop SleepOnLowBattery
launchctl stop SleepOnLowBatterySound

if test -e $SoundScript; then rm -R $SoundScript; fi

echo
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