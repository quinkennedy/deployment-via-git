#!/usr/bin/env bash
#
#script tested on OSX 10.8
#commands developed against OSX 10.7

#get the directory that the script is located
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#elevate to root
echo ""
sudo -v -p "Please enter the administrator's password: "

#bootstrapping commands for OSX taken from https://github.com/adenine/Interactive-Installation-Bootstrap/wiki/Check-and-Set-Computer-Settings on Nov 24th 2013

# turn off software update
sudo softwareupdate --schedule off

#turn off bluetooth
### This seems to have no effect on 10.8.3
sudo defaults write /Library/Preferences/com.apple.Bluetooth.plist ControllerPowerState -bool NO
killall blued
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.blued.plist
### Another suggestion I ran across, didn't seem to help
#sudo networksetup -setnetworkserviceenabled "Bluetooth DUN" off
#sudo networksetup -setnetworkserviceenabled "Bluetooth PAN" off
### Some more shots in the dark
#launchctl remove com.apple.bluetoothUIServer
#launchctl remove com.apple.bluetoothAudioAgent
### This finally worked on re-start, but seems a little heavy-handed
sudo mkdir -p /System/Library/Extensions-Disabled
sudo mv /System/Library/Extensions/IOBluetooth* /System/Library/Extensions-Disabled/

#manage sleep and power settings
systemsetup -setsleep Never
systemsetup -setdisplaysleep Never
systemsetup -setharddisksleep Never
systemsetup -setwakeonnetworkaccess on
systemsetup -setallowpowerbuttontosleepcomputer off
systemsetup -setrestartpowerfailure on
sudo pmset repeat cancel

#auto login
sudo defaults write /Library/Preferences/com.apple.loginwindow "autoLoginUser" "Faile"

#disable crash reporting
defaults write com.apple.CrashReporter DialogType none

#disable expose?
defaults write com.apple.dock mcx-expose-disabled -bool true

#hide dock
defaults write com.apple.dock autohide -bool YES

#force dock to apply previous 2 changes
killall Dock

#disable dashboard
defaults write com.apple.dashboard mcx-disabled -boolean YES

#disable screensavers
defaults -currentHost write com.apple.screensaver idleTime 0

#enable remote management
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate -configure -access -on -clientopts -setvnclegacy -vnclegacy yes -clientopts -setvncpw -vncpw mypasswd -restart -agent -privs -all
systemsetup -setremotelogin on
systemsetup -setremoteappleevents on

#hide drives on desktop
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool NO
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool NO
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool NO

#apply the desktop settings
killall Finder

#install chrome
### this didn't work, you will need to install Chrome manually
#cp -r "$DIR/Google Chrome.app" /Applications/

#replace the plist file with our custom one
cp -f "$DIR/_03_2_Info.plist" /Applications/Google\ Chrome.app/Contents/Info.plist

#activate it
/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --new-page --activate-on-launch --no-first-run=1 "file://localhost$DIR/_03_1_index.html"
#control won't return to the terminal until Chrome is quit
#just wait a second to let anything clean up, no particular reason
sleep 1

#disable chrome auto-update
defauts write com.google.Keystone.Agent checkInterval 0

#done!
echo ""
echo "Thanks! You are done."
read -p "Press [Enter] to quit..."
killall Terminal
#disable bluetooth?
#sudo networksetup -setnetworkserviceenabled "Bluetooth DUN" off
#sudo networksetup -setnetworkserviceenabled "Bluetooth PAN" off
#launchctl remove com.apple.bluetoothUIServer
#launchctl remove com.apple.bluetoothAudioAgent
#sudo mkdir -p /System/Library/Extensions-Disabled
#sudo mv /System/Library/Extensions/IOBluetooth* /System/Library/Extensions-Disabled/