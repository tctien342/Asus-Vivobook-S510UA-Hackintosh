# Asus VivoBook S15 S510UA/ F510UA series

**This build enables you to run macOS on your VivoBook as long as it matches below System specifications as close as possible - verified with macOS Mojave 10.14.6 - Big Sur 11.2.1**

![Alt text](https://ivanov-audio.com/wp-content/uploads/2014/01/Hackintosh-Featured-Image.png)

# Details

    Version:    	11.0 RC (Release Candidate) 1
    Date:       	Feb. 23, 2021
    Status: 	Stable
    Support:    	All BIOS (verified 301-310)
    Technology:	OpenCore and Clover with ACPI hotpatch by RehabMan  
   Changelog:   	see [Changelog.md](https://github.com/tctien342/Asus-Vivobook-S510UA-Hackintosh/blob/master/ChangeLog.md)

# System specification

    • Model Name:		Asus VivoBook S510UA
    • CPU:			Intel Core i5-8250U
    • Video Graphics:	Intel UHD 620
    • Wi-Fi:		Intel Dual Band Wireless-AC 8265 - with bluetooth // REPLACED WITH DW1560 or FRU 04X6020 (AirDrop and Handoff Working perfectly)
    • Card Reader:		Realtek (RTL8411B_RTS5226_RTS5227)
    • Camera:		ASUS UVC HD
    • Audio:		Conexant Audio CX8050
    • Touchpad:		ELAN 1300
    • Keyboard Backlight:	Yes
    • BIOS Version:		x510UAR 310

Users with VivoBooks *without* keyboard backlight are advised to rather use [whatnameisit's X510UA-BQ490 repo](https://github.com/whatnameisit/Asus-Vivobook-X510UA-BQ490-Catalina-10.15.3-Hackintosh). He also has been tending his repo very actively so it is more likely to be as up-to-date as possible!

# Unsupported Hardware

    1. dGPU like 940MX
    2. Fingerprint reader
    3. 'FN + media controller' key combo
    4. Intel  Wi-Fi - replacement see below

# Known Issues, weaknesses and oddities

1. The **Touchpad** is not perfect - you *might* encounter occasional hangs and possibly erratic movements because **a)** it's a weak piece of hardware to begin with (even under Windows), and **b)** the VoodooI2C driver for macOS is still work in progress. With VoodooI2C v.2.0.3 (used for now for stability and reliability), certain minor functions don't work: Fn+F9 (Touchpad off/on) and some touchpad gestures like pinch zoom. For more info see [TOUCHPAD » consolidated links to related issues](https://github.com/tctien342/Asus-Vivobook-S510UA-High-Sierra-10.13-Hackintosh/issues/48).
2. Apple **Safe Sleep** ("***Hibernate***") doesn't work and has been disabled. In any case, additionally apply "*post macOS Installations/set hibernatemode to 0*"
3. **Battery life** isn't great to begin with, not even in Windows. On some VivoBooks it seems to be even worse in macOS. A S510UQ user ([Quhuy0410](https://www.tonymacx86.com/members/quhuy0410.2255980/)) claims longer battery life with model MacBookAir8,2 chosen in the SMBIOS section. Feel free to experiment. Mind that CPUFriendDataProvider.kext ***must*** match your chosen model. For that sake, navigate to "*post macOS Installations/[Optional]/change CPU Performance*".
4. **Sleep**: in macOS, the VivoBook needs appr. 15 secs. to power down completely. You will hear the fan spin up again before the system finally settles (power LED on the left blinking white, indicating sleep mode).
4. **Sound quality** isn't great because the speakers are mediocre in general, and to make things even worse, Asus placed them into the bottom of the case, mostly facing down. For tips to improve the sound, please look at "[docs/BetterSound.html](https://htmlpreview.github.io/?https://github.com/tctien342/Asus-Vivobook-S510UA-Hackintosh/blob/master/docs/BetterSound.html)"

# Tools to use
* Your favorite hackintosh USB installer maker (e.g. [UniBeast](https://www.unibeast.com/))
* [Clover Configurator](https://mackie100projects.altervista.org/download-clover-configurator/)
* Hackintool ([Forum thread](https://www.insanelymac.com/forum/topic/335018-hackintool-v286/) | [Direct download always latest version](http://headsoft.com.au/download/mac/Hackintool.zip))
* Kext Updater ([Download](https://bitbucket.org/profdrluigi/kextupdater/downloads/) | [Main forum thread](https://www.hackintosh-forum.de/forum/thread/32621-kext-updater-neue-version-3-x/) {German})
* somewhat outdated but still seems to be working fine even in Catalina: [KCPM Utility Pro](https://www.firewolf.science/tag/kcpm-utility-pro/) (2017-06-22, therefore use with caution!)


# Steps to install macOS


1. Enter the BIOS and set the following options:

	- Display memory: 64MB
	- Disable VT-D
	- Disable Fast Boot
	- Disable Secure Boot
	- recommended: set the EFI partition with Clover as the first boot loader

2. Prepare a macOS installer on a USB flash drive with Clover added (use e.g. Unibeast to create it)
3. Replace the EFI folder in the USB EFI partition with this INCLUDED EFI FOLDER
4. Boot into USB and select macOS installer
5. On first boot Trackpad will not work - you do need a mouse connected via USB.
6. Follow macOS install instructions (you can find them in your favorite hackintosh forum) to boot into macOS.

# Steps after installing macOS
    
1. **Download this repo**, preferably as **.dmg package** from the [Releases](https://github.com/tctien342/Asus-Vivobook-S510UA-Hackintosh/releases) section because a) each release was tested thoroughly and can be considered a stable mile stone for most users, and b) macOS native icons and labels are maintained.<br/>  Alternatively you can download the repo at it's current "0-day" state if you see that's more recent than the latest release date and contains one or more updates you are looking for via the green "Clone or Download" button on the top right of the [repo's main page](https://github.com/tctien342/Asus-Vivobook-S510UA-Hackintosh), "Download ZIP". Consider the non-release state as BETA, and be aware that GitHub does ***not*** (yet?) sustain macOS native icons and labels in its open repo!

2. Open the folder "**post macOS Installations**" and install *all* from within its subfolders for Audio Input, Hibernate prevention, additional function keys, etc. Also (strongly recommended!) study and consider the content of the folder [Optional].
2. Recommended: **install all kexts** from EFI/CLOVER/kexts/Other (and any kext from the subfolder matching your macOS version) **to L/E (/Library/Extensions)** with Hackintool (icon 'Tools' in its window bar, first kext icon in the bottom bar, install kexts, final kext icon in the bottom bar 'Rebuild KextCache and repair Permissions'), reboot
3. Now trackpad and audio input should work. Next you need to **fill the EFI partition on your internal hard disk with the Clover EFI folder**. You can use Clover Configurator to mount your System EFI. Next back up the existing System EFI folder and copy this release's EFI folder to your system EFI partition
4. Run Clover Configurator, click onto **SMBIOS** in the side bar on the left. Under 'System', next to 'Serial Number', click onto the 'Generate New' button. That will change both, system and board serial number, which should hopefully enable you to use iCloud
5. **Reboot and ENJOY :)**

# _ATTENTION - be careful with Updates_!
**Be especially mindful with VirtualSMC Updates!** If the versions of VirtualSMC, accompanying plugin kexts (**SMCProcessor**, **SMCBatteryManager**) and corresponding **efi driver** (EFI/CLOVER/drivers/UEFI/**VirtualSmc.efi**) do not match, touchpad and battery issues may arise! Please make sure you download the most recent stable release of the **complete** SMC package [from its repo](https://github.com/acidanthera/VirtualSMC/releases) and replace ***each*** existing file with the matching new one.

# Wi-Fi Replacement

1. Replace your existing Wi-Fi/ Bluetooth card with either a **Fenvi BCM94360NG** (read [whatnameisit's findings about it](https://github.com/tctien342/Asus-Vivobook-S510UA-Hackintosh/issues/46#issuecomment-592947028) under 2.), a **DW1560** (most wide-spread and best supported) or a FRU 04X6020 (or a different kind if you can find a better one)
2. Follow the instructions in "[post macOS Installations/Bluetooth AFTER card replacement/Wi-Fi & Bluetooth ReadMe.md](https://github.com/tctien342/Asus-Vivobook-S510UA-High-Sierra-10.13-Hackintosh/blob/master/post%20macOS%20Installations/Bluetooth%20AFTER%20card%20replacement/Wi-Fi%20%26%20Bluetooth%20ReadMe.md)"
3. Rebuild kext cache and repair L/E permissions, e.g. with Kext Updater, Hackintool etc.
4. Reboot and **ENJOY even more** :)

### Special Credits for this repo to these hackintoshers:
**tctien342** (originator), **LeeBinder** (current repo maintainer), **whatnameisit** (main contributor), **hieplpvip** (contributor), **fewtarius** (facilitator), any to many *MANY* others..
