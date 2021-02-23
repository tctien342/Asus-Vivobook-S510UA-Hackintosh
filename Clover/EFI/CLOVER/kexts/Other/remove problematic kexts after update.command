#!/bin/bash
clear

kext_1=AirportBrcmFixup.kext/Contents/PlugIns/AirPortBrcm4360_Injector.kext
kext_2=VoodooPS2Controller.kext/Contents/PlugIns/VoodooPS2Trackpad.kext
kext_3=VoodooPS2Controller.kext/Contents/PlugIns/VoodooPS2Mouse.kext
kext_4=VoodooPS2Controller.kext/Contents/PlugIns/VoodooInput.kext
echo
echo This script will remove the following kexts in the folder it resides in:
echo
echo $kext_1
echo $kext_2
echo $kext_3
echo $kext_4
echo
read -p "Proceed (y|n)? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
cd "$(dirname "$0")"
rm -Rv $kext_1
rm -Rv $kext_2
rm -Rv $kext_3
rm -Rv $kext_4
echo
echo Done!
echo
fi