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
if test -e $Plist; then launchctl stop SleepOnLowBattery && launchctl unload $Plist && rm -R $Plist; fi
if test -e $SoundPlist; then launchctl stop SleepOnLowBatterySound && launchctl unload $SoundPlist && rm -R $SoundPlist; fi
cd "$(dirname "$0")"
echo "Installing.."
sudo cp -R InstallerData/SleepOnLowBatterySound.scpt /etc
if test ! -d ~/Library/LaunchAgents; then mkdir ~/Library/LaunchAgents; fi
cp -R InstallerData/SleepOnLowBatterySound.plist ~/Library/LaunchAgents
sudo chmod +rx /etc/SleepOnLowBatterySound.scpt
chown -R $(whoami) ~/Library/LaunchAgents/
chmod 755 ~/Library/LaunchAgents/SleepOnLowBatterySound.plist
#chmod 604 ~/Library/LaunchAgents/SleepOnLowBatterySound.plist
launchctl load ~/Library/LaunchAgents/SleepOnLowBatterySound.plist
launchctl start SleepOnLowBatterySound
echo
echo "..done!"
echo
echo "Now I recommend you download the pleasant Allision onto your Mac :)"
echo
read -r -p "Continuing in 3 seconds..." -t 3 -n 1 -s
echo
echo
osascript "Extras/download new voice(s).scpt"
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