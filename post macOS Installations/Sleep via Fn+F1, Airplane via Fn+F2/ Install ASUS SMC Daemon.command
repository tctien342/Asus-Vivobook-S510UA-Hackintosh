#!/bin/bash
clear
cd "$(dirname "$0")"

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
echo "-----------------------"
echo "INSTALL ASUS SMC DAEMON"
echo "-----------------------"
echo
echo "Installing.."
echo
# remove AsusFnKeysDaemon
sudo launchctl unload /Library/LaunchAgents/com.hieplpvip.AsusFnKeysDaemon.plist 2>/dev/null
sudo pkill -f AsusFnKeysDaemon
sudo rm /usr/bin/AsusFnKeysDaemon 2>/dev/null
sudo rm /Library/LaunchAgents/com.hieplpvip.AsusFnKeysDaemon.plist 2>/dev/null

# remove old AsusSMCDaemon
sudo launchctl unload /Library/LaunchAgents/com.hieplpvip.AsusSMCDaemon.plist 2>/dev/null
sudo rm /usr/bin/AsusSMCDaemon 2>/dev/null

sudo mkdir -p /usr/local/bin/
sudo chmod -R 755 /usr/local/bin/
sudo cp AsusSMCDaemon /usr/local/bin/
sudo chmod 755 /usr/local/bin/AsusSMCDaemon
sudo chown root:wheel /usr/local/bin/AsusSMCDaemon

sudo cp com.hieplpvip.AsusSMCDaemon.plist /Library/LaunchAgents
sudo chmod 644 /Library/LaunchAgents/com.hieplpvip.AsusSMCDaemon.plist
sudo chown root:wheel /Library/LaunchAgents/com.hieplpvip.AsusSMCDaemon.plist

sudo launchctl load /Library/LaunchAgents/com.hieplpvip.AsusSMCDaemon.plist
echo "..done!"
echo
}

trap '{ _clean_up; exit 1; }' INT

if [[ `id -u` -ne 0 ]];
  then
    echo "-----------------------"
    echo "INSTALL ASUS SMC DAEMON"
    echo "-----------------------"
    echo
    echo "Installing the ASUS SMC Daemon which enables Sleep (Fn+F1) and Airplane (Fn+F2) modes."
    echo
    echo "This script must be run as root. Please enter your password"
    sudo --prompt "then press ENTER: " "$0"
  else
    main
fi

#===============================================================================##
## EOF #
##==============================================================================##