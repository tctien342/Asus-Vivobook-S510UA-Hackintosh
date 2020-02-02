#!/bin/bash
clear

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
cd "$(dirname "$0")"
echo "Installing.."
sudo cp -R InstallerData/SleepOnLowBattery.scpt /etc
if test ! -d ~/Library/LaunchAgents; then mkdir ~/Library/LaunchAgents; fi
cp -R InstallerData/SleepOnLowBattery.plist ~/Library/LaunchAgents
sudo chmod +rx /etc/SleepOnLowBattery.scpt
chown -R $(whoami) ~/Library/LaunchAgents/
chmod 755 ~/Library/LaunchAgents/SleepOnLowBattery.plist
#chmod 604 ~/Library/LaunchAgents/SleepOnLowBattery.plist
launchctl load ~/Library/LaunchAgents/SleepOnLowBattery.plist
launchctl start SleepOnLowBattery
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