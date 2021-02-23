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
    • Wi-Fi & Bluetooth:	Intel Dual Band Wireless-AC 8265  // replacements see below
    • Card Reader:		Realtek (RTL8411B_RTS5226_RTS5227)
    • Camera:		ASUS UVC HD
    • Audio:		Conexant Audio CX8050
    • Touchpad:		ELAN 1300
    • Keyboard Backlight:	Yes
    • BIOS Version:		x510UAR 310

This repo is based on whatnameisit's brilliant and cutting-edge [repo for his VivoBook X510UA-BQ490](https://github.com/whatnameisit/Asus-Vivobook-X510UA-BQ490-Hackintosh) based on OpenCore ("OC"). The two main differences are:

1. re-added keyboard backlight support
2. re-added a Clover EFI as *secondary* bootloader alternative by backporting OC's ACPI into Clover config.

Users with VivoBooks *without* keyboard backlight are advised to rather use [whatnameisit's repo](https://github.com/whatnameisit/Asus-Vivobook-X510UA-BQ490-Hackintosh). He also has been tending it very actively so it is more likely to be as up-to-date as possible! Note that **he does *not* offer a Clover EFI** and that **you *do* need to be able to handle OpenCore**! _In any case_ please do read through his [ReadME](https://github.com/whatnameisit/Asus-Vivobook-X510UA-BQ490-Hackintosh) because it contains a wealth of important info and links which also apply to this repo!

Of the two bootloaders offered in this repo, [OpenCore](https://github.com/acidanthera/OpenCorePkg) and [Clover](https://github.com/CloverHackyColor/CloverBootloader), OC can be considered the preferred one. As per whatnameisit and others, in contrast to OC, Clover at this point does not support OEMTableID, masking and many other features. For a more detailed comparison, you could read [Why OpenCore over Clover and others](https://dortania.github.io/OpenCore-Install-Guide/why-oc.html#opencore-features).

# Unsupported Hardware & Features

    • dGPU like 940MX
    • Fingerprint reader
    • 'FN + media controller' key combo
    • Intel  Wi-Fi - replacements see below
The support for DRM contents is limited due to incompatible firmware. Please see the [DRM Compatibility Chart](https://github.com/acidanthera/WhateverGreen/blob/master/Manual/FAQ.Chart.md)

# Known Issues, weaknesses and oddities

1. The **Touchpad** is not perfect - you *might* encounter occasional hangs and possibly erratic movements because **a)** it's a weak piece of hardware to begin with (even under Windows), and **b)** the VoodooI2C driver for macOS is still work in progress. Some older info is archived at [TOUCHPAD » consolidated links to related issues](https://github.com/tctien342/Asus-Vivobook-S510UA-High-Sierra-10.13-Hackintosh/issues/48).
2. Apple **Safe Sleep** ("***Hibernate***") doesn't work and has been disabled. In any case, additionally apply "*post macOS Installations/set hibernatemode to 0*"
3. **Battery life** isn't great to begin with, not even in Windows. On some VivoBooks it seems to be even worse in macOS. A S510UQ user ([Quhuy0410](https://www.tonymacx86.com/members/quhuy0410.2255980/)) claims longer battery life with model MacBookAir8,2 chosen in the SMBIOS section. Feel free to experiment. Mind that CPUFriendDataProvider.kext ***must*** match your chosen model. For that sake, navigate to "*post macOS Installations/[Optional]/change CPU Performance*".
4. **Sleep**: in macOS, the VivoBook needs appr. 15 secs. to power down completely. You will hear the fan spin up again before the system finally settles (power LED on the left blinking white, indicating sleep mode).
4. **Sound quality** isn't great because the speakers are mediocre in general, and to make things even worse, Asus placed them into the bottom of the case, mostly facing down. For tips to improve the sound, please look at "[docs/BetterSound.html](https://htmlpreview.github.io/?https://github.com/tctien342/Asus-Vivobook-S510UA-Hackintosh/blob/master/docs/BetterSound.html)"

# Tools to use
* Your favorite macOS or hackintosh USB installer maker
* Hackintool: [Forum thread](https://www.insanelymac.com/forum/topic/335018-hackintool-v286/) | [Direct download always latest version](http://headsoft.com.au/download/mac/Hackintool.zip)
* Kext Updater: [Download](https://bitbucket.org/profdrluigi/kextupdater/downloads/) | [Main forum thread](https://www.hackintosh-forum.de/forum/thread/32621-kext-updater-neue-version-3-x/) {German}

 ### OpenCore:
 * [OpenCore Configurator](https://mackie100projects.altervista.org/download-opencore-configurator/)
 * [Online Reference Manual](https://dortania.github.io/docs/latest/Configuration.html) | [Dortania guides](https://dortania.github.io/getting-started/)


 ### Clover:
 * [Clover Configurator](https://mackie100projects.altervista.org/download-clover-configurator/)
 *  [Online Documentation](https://drovosek01.github.io/CloverHackyColor-WebVersion/) (Russian & English)


# Steps to install macOS


1. Enter the BIOS and set the following options:

	- Display memory: 64MB
	- Disable VT-D
	- Disable Fast Boot
	- Disable Secure Boot
	- recommended: set the EFI partition with Clover as the first boot loader

2. Prepare a macOS installer on a USB flash drive with OC or Clover added
3. Replace the EFI folder in the USB EFI partition with the matching one (OC or Clover) from this repo
4. Boot into USB and select macOS installer
5. Recommended: a mouse connected via USB in case Trackpad does not work right away
6. Follow macOS install instructions (you can find them in your favorite hackintosh forum) to boot into macOS.

# Steps after installing macOS
    
1. **Download this repo**, preferably as **.dmg package** from the [Releases](https://github.com/tctien342/Asus-Vivobook-S510UA-Hackintosh/releases) section because a) each release was tested thoroughly and can be considered a stable mile stone for most users, and b) macOS native icons and labels are maintained.<br/>  Alternatively you can download the repo at it's current "0-day" state if you see that's more recent than the latest release date and contains one or more updates you are looking for via the green "Clone or Download" button on the top right of the [repo's main page](https://github.com/tctien342/Asus-Vivobook-S510UA-Hackintosh), "Download ZIP". Consider the non-release state as BETA, and be aware that GitHub does ***not*** (yet?) sustain macOS native icons and labels in its open repo!

2. Open the folder "**post macOS Installations**" and install *all* from within its subfolders for Hibernate prevention, additional function keys, etc. Also (strongly recommended!) study and consider the content of the folder [Optional]!

3. **Fill your internal hard disk's EFI partition with the OC or Clover EFI folder**. You can use the matching Configurator to mount your system ESP (EFI System Partition). Next back up the existing System EFI folder and copy one of this release's EFI folders to your system's ESP.

4. **OpenCore Configurator**:
    * click onto **PlatformInfo** in the side bar on the left
    * on the right top, click onto the 1st tab 'DataHub - Generic - PlatformNVRAM'. You will see four text fields with `update this field`
    * open a new empty instance of OC C leaving this instance open, navigate to the same tab, click onto the up/down arrow box next to `Check Coverage`, choose `MacBookPro15,4`
    * in the provided OC config.plist in the 1st window, fill ONLY the text fields reading `update this field` with the corresponding values from the 2nd window instance.
    * save
 
     **Clover Configurator**: click onto **SMBIOS** in the side bar on the left. Under 'System', next to 'Serial Number', click onto the `Generate New` button. That will change both, system and board serial number. Save.

 Above steps are necessary to - amongst other things - hopefully be able to use iCloud.

5. **Reboot and ENJOY :)**


# Wi-Fi Replacement

Replace your existing Wi-Fi/ Bluetooth M.2 card preferably with a [Fenvi BCM94360NG](https://www.google.com/search?btnG=Search&q=Fenvi+BCM94360NG+M.2) because it has macOS native Wi-Fi and Bluetooth chipset and IDs. If you do so, you can/ should remove *ALL* related kexts from inside your EFI folder (`AirportBrcmFixup`, `BrcmBluetoothInjector`, `BrcmFirmwareData`, `BrcmPatchRAM2`, `BrcmPatchRAM3`).

Alternatively you can use a [Dell DW1560](https://www.google.com/search?btnG=Search&q=Dell+DW1560+M.2) or a [Lenovo FRU 04X6020](https://www.google.com/search?btnG=Search&q=Lenovo+FRU+04X6020+M.2) (or even a different kind if you can find a better one)

Reboot and **ENJOY even more** :)

# _ATTENTION - be careful with Updates_!
**Be especially mindful with VirtualSMC Updates!** The VirtualSMC version should match those of accompanying plugin kexts (**SMCProcessor**, **SMCBatteryManager**) to avoid touchpad and battery issues! Please make sure you download the most recent stable release of the **complete** SMC package [from its repo](https://github.com/acidanthera/VirtualSMC/releases) and replace ***each*** existing file with the matching new one.

_________________________
## Special Credits for this repo to these hackintoshers:
**whatnameisit**: main contributor, maintainer of the [VivoBook X510UA-BQ490 repo](https://github.com/whatnameisit/Asus-Vivobook-X510UA-BQ490-Hackintosh/) | **tctien342**: originator of this VivoBook S15 repo ([archived](https://github.com/tctien342/Asus-Vivobook-S510UA-Hackintosh/releases)) | **hieplpvip**: originator of the [base ZenBook repo](https://github.com/hieplpvip/Asus-Zenbook-Hackintosh) & [AsusSMC](https://github.com/hieplpvip/AsusSMC), contributor | **[fewtarius](https://github.com/fewtarius)**: facilitator; and to [many](https://github.com/whatnameisit/Asus-Vivobook-X510UA-BQ490-Hackintosh/blob/master/README.md#credits) *MANY* others....
