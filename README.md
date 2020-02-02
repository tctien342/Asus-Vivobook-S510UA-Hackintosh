# Asus VivoBook S15 F510UA series

**This build enables you to run macOS on your VivoBook as long as it matches below System specifications as close as possible - verified with macOS 10.13.6 - 10.15.3**

![Alt text](https://ivanov-audio.com/wp-content/uploads/2014/01/Hackintosh-Featured-Image.png)

# Details

    Version:    	10.0 RC2
    Date:       	Feb. 2, 2020
    Status: 	Stable
    Support:    	All BIOS (verfified 301-310)
    Technology:	Clover with ACPI hotpatch by RehabMan, ported from Asus ZenBook by hieplpvip
    Changelog:   	see Changelog.rtf

# System specification

    1.Model Name:		Asus VivoBook S510UA
    2.CPU:			Intel Core i5-8250U
    3.Video Graphics:	Intel UHD 620
    4.Wi-Fi:		Intel Dual Band Wireless-AC 8265 - with bluetooth // REPLACED WITH DW1560 or FRU 04X6020 (AirDrop and Handoff Working perfectly)
    5.Card Reader:		Realtek (RTL8411B_RTS5226_RTS5227)
    6.Camera:		ASUS UVC HD
    7.Audio:		Conexant Audio CX8050
    8.Touchpad:		ELAN 1300
    9.BIOS Version:		x510UAR 310

# Unsupported Hardware

    1. DGPU like 940MX
    2. Fingerprint reader
    3. 'FN + media controller' key combo
    4. Intel  Wi-Fi - replacement see below

# Known Issues

1. The Touchpad is not perfect (occasional hangs and possibly erratic movements) because a) it's a weak piece of hardware to begin with (even under Windows), and b) the VoodooI2C driver for macOS is still work in progress. For more info see [Touchpad Info](https://github.com/tctien342/Asus-Vivobook-S510UA-High-Sierra-10.13-Hackintosh/issues/48).
2. Apple Safe Sleep ("Hibernate") does not work and is disabled

# Tools to use
* Your favorite hackintosh USB installer maker (e.g. [UniBeast](https://www.unibeast.com/))
* [Clover Configurator](https://mackie100projects.altervista.org/download-clover-configurator/)
* Hackintool ([Forum thread](https://www.insanelymac.com/forum/topic/335018-hackintool-v286/) | [Direct download always latest version](http://headsoft.com.au/download/mac/Hackintool.zip))
* Kext Updater ([Download](https://bitbucket.org/profdrluigi/kextupdater/downloads/) | [Main forum thread](https://www.hackintosh-forum.de/forum/thread/32621-kext-updater-neue-version-3-x/) {German})


# Steps to install macOS

    1. Prepair a macOS installer on a USB flash drive with Clover added (use e.g. Unibeast to create it)
    2. Replace the EFI folder in the USB EFI partition with this INCLUDED EFI FOLDER
    3. Boot into USB and select macOS installer
    4. On first boot Trackpad will not work - you do need a mouse connected via USB.
    5. Follow macOS install instructions (you can find them in you favorite hackintosh forum) to boot into macOS.

# Steps after installing macOS
    
1. Open the folder "**post macOS Installations**" and install all from within its subfolders for Audio Input, additional function keys, etc. Also study and consider the content of the folder [Optional].
2. Recommended: install all kexts from EFI/CLOVER/kexts/Other to L/E (/Library/Extensions) with Hackintool (icon 'Tools' in its window bar, first kext icon in the bottom bar, install kexts, final kext icon in the bottom bar 'Rebuild KextCache and repair Permissions'), reboot
3. Now trackpad and audio should work. Next you need to fill the EFI partition on your internal hard disk with the Clover EFI folder. You cam use Clover Configurator to mount your System EFI. Next back up the existing System EFI folder and copy this release's EFI folder to your system EFI partition
4. Run Clover Configurator, click onto SMBIOS in the side bar on the left. Under 'Systen', next to 'Serial Number', click onto the 'Generate New' button. That will change both, system and board serial number, which should hopefully enable you to use iCloud
5. Reboot and ENJOY :)

# Wi-Fi Replacement

1. Replace your existing Wi-Fi/ Bluetooth card with either a DW1560 (recommended because most wide-spread and best supported) or a FRU 04X6020 (or a different kind if you can find a better one)
2. Follow the instructions in "[post macOS Installations/Bluetooth AFTER card replacement/Wi-Fi & Bluetooth ReadMe.md](https://github.com/tctien342/Asus-Vivobook-S510UA-High-Sierra-10.13-Hackintosh/blob/master/post%20macOS%20Installations/Bluetooth%20AFTER%20card%20replacement/Wi-Fi%20%26%20Bluetooth%20ReadMe.md)"
3. Rebuild kext cache and repair L/E permissions, e.g. with Kext Updater, Hackintool etc.
4. Reboot and ENJOY even more :)
