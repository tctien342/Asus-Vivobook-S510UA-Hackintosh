#!/bin/bash
clear

defaults delete com.apple.preferences.softwareupdate LatestMajorOSSeenByUserBundleIdentifier && softwareupdate --list

#killall Dock

echo