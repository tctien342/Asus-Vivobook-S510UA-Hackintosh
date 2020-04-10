#!/bin/bash
clear

kextname="CodecCommander.kext"

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
echo "Make sure you have placed $kextname next to this script,"
echo "then press any key to continue:"
read -n 1 -s -r -p ""
echo
cd "$(dirname "$0")"
echo "Installing kext.."
sudo cp -R $kextname /Library/Extensions
sudo chmod -R 645 /Library/Extensions/$kextname
sudo chown -R root:wheel /Library/Extensions/$kextname
echo "..done!"
echo
echo "Rebuilding kextcache.."
sudo kextcache -i / && sudo kextcache -u /
echo "..done!"
echo
read -p "Reboot now for changes to take effect (y | n)? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
shutdown -r now
fi
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
