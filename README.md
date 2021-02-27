# Asus VivoBook S15 S510UA/ F510UA series

**This build enables you to run macOS on your VivoBook as long as it matches below System specifications as close as possible - verified with macOS Mojave 10.14.6 - Big Sur 11.2.1**

![Alt text](https://ivanov-audio.com/wp-content/uploads/2014/01/Hackintosh-Featured-Image.png)

# Details

    Version:    	11.0 RC (Release Candidate) 3
    Date:       	Feb. 27, 2021
    Status: 	Stable
    Support:    	All BIOS (verified 301-310)
    Technology:	OpenCore and Clover with ACPI hotpatch by RehabMan  
   Changelog:   	see [Changelog.md](https://github.com/tctien342/Asus-Vivobook-S510UA-Hackintosh/blob/master/ChangeLog.md)

# System specification

    • Model Name:		Asus VivoBook S510UA BQ514T
    • CPU:			Intel Core i5-8250U Kaby Lake R 8th Gen. i5
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

Of the two bootloaders offered in this repo, [OpenCore](https://github.com/acidanthera/OpenCorePkg) and [Clover](https://github.com/CloverHackyColor/CloverBootloader), OC can be considered the preferred one despite of still being beta by version number. As per whatnameisit and others, in contrast to OC, Clover at this point does not support OEMTableID, masking and many other sophisticated features. For a more detailed comparison, you could read [Why OpenCore over Clover and others](https://dortania.github.io/OpenCore-Install-Guide/why-oc.html#opencore-features).

<img src="https://raw.githubusercontent.com/tctien342/Asus-Vivobook-S510UA-Hackintosh/master/OpenCore/Screenshot%20OC%20GUI.jpg" width="45%" height="" /> <img src="https://raw.githubusercontent.com/tctien342/Asus-Vivobook-S510UA-Hackintosh/master/Clover/Screenshot%20Clover%20GUI.jpg" width="45%" height="" />

# Unsupported Hardware & Features

    • dGPU like NVIDIA GeForce 940MX
    • Fingerprint reader
    • FN + media controller key combo
    • Apple Safe Sleep ("Hibernate")
    • Intel Wi-Fi - replacement see below
The support for DRM contents is limited due to incompatible firmware. Please see the [DRM Compatibility Chart](https://github.com/acidanthera/WhateverGreen/blob/master/Manual/FAQ.Chart.md)

# VivoBooks with an additional dGPU (NVIDIA GeForce 940MX, MX150 etc.)

**OpenCore** via OpenCore Configurator:

- ACPI: enable `SSDT-RP01_PEGP.aml`
- NVRAM > 7C436110-AB2A-4BBB-A880-FE41995C9F82 > boot-args: add `-wegnoegpu`
- save & reboot

**Clover:**

- In the file system, navigate to `EFI/CLOVER/ACPI/patched/disbale dGPU (NVIDIA etc.)` and move `SSDT-RP01_PEGP.aml` one level higher into `patched`
- via Clover Configurator: Boot > Arguments: add `-wegnoegpu`
- save & reboot

If there is more than one boot-arg, make sure you separate them from each other with a space!

# Known Issues, weaknesses and oddities

1. The **Touchpad** is not perfect - you *might* encounter occasional hangs and possibly erratic movements because **a)** it's a weak piece of hardware to begin with (even under Windows), and **b)** the VoodooI2C driver for macOS is still work in progress. Some older info is archived at [TOUCHPAD » consolidated links to related issues](https://github.com/tctien342/Asus-Vivobook-S510UA-High-Sierra-10.13-Hackintosh/issues/48).
2. Apple **Safe Sleep** ("Hibernate", "Deep Sleep") doesn't work and has been disabled. In any case, additionally apply "*post macOS Installations/set hibernatemode to 0*"
3. **Battery life** isn't great to begin with, not even in Windows. On some VivoBooks it seems to be even worse in macOS. A S510UQ user ([Quhuy0410](https://www.tonymacx86.com/members/quhuy0410.2255980/)) claims longer battery life with model `MacBookAir8,2` chosen in the SMBIOS section (of Clover config.plist). Feel free to experiment. Mind that `CPUFriendDataProvider.kext` ***must*** match your chosen model. For that sake, navigate to `post macOS Installations/[Optional]/change CPU Performance`
4. **Sleep**: in macOS, the VivoBook needs appr. 15 secs. to power down completely. You will hear the fan spin up again before the system finally settles (power LED on the left blinking white, indicating sleep mode).
5. **Swapped `<` and `^` keys**: If you have a keyboard with a `<` key next to the left ⇧ and a `^` key below the `ESC` key ([image](https://i.ebayimg.com/images/g/3WUAAOSw9ixe-fAq/s-l1600.jpg)) and these keys are reversed, and you neither want to use a tool like [Karabiner-Elements](https://karabiner-elements.pqrs.org/) nor know how to fix that via SSDT, simply stick to [VoodooPS2Controller.kext v.2.1.9](https://github.com/acidanthera/VoodooPS2/releases/tag/2.1.9) which is the only version I know to map these keys correctly for such VivoBook S15 models like mine.

# Tools to use
* Your favorite macOS or hackintosh USB installer maker
* Hackintool: [Forum thread](https://www.insanelymac.com/forum/topic/335018-hackintool-v286/) | [Direct download always latest version](http://headsoft.com.au/download/mac/Hackintool.zip)
* Kext Updater: [Download](https://bitbucket.org/profdrluigi/kextupdater/downloads/) | [Main forum thread](https://www.hackintosh-forum.de/forum/thread/32621-kext-updater-neue-version-3-x/) {German}
* A XML property list editor like [PrefEdit](https://www.bresink.com/osx/PrefEdit.html) if you don't have Apple's [XCode](https://apps.apple.com/us/app/xcode/id497799835) installed

 ### OpenCore:
 * [OpenCore Configurator](https://mackie100projects.altervista.org/download-opencore-configurator/)
 * [Online Reference Manual](https://dortania.github.io/docs/latest/Configuration.html) | [Dortania guides](https://dortania.github.io/getting-started/)


 ### Clover:
 * [Clover Configurator](https://mackie100projects.altervista.org/download-clover-configurator/)
 *  [Online Documentation](https://drovosek01.github.io/CloverHackyColor-WebVersion/) (Russian & English)

# Steps to install macOS


1. Enter the BIOS and set the following options:

	- Display memory: 64MB
	- Disable Fast Boot
	- Disable Secure Boot
	- recommended: set the EFI partition with OC as the first boot loader

2. Prepare a macOS installer on a USB flash drive with OC or Clover added
3. Replace the EFI folder in the USB EFI partition with the matching one (OC or Clover) from this repo
4. Boot into USB and select macOS installer
5. Recommended: a mouse connected via USB in case Trackpad does not work right away
6. Follow macOS install instructions (you can find them in your favorite hackintosh forum) to boot into macOS.

# Steps after installing macOS
    
1. **Download this repo**, preferably as **.dmg package** from the [Releases](https://github.com/tctien342/Asus-Vivobook-S510UA-Hackintosh/releases) section because **a)** each release was tested thoroughly and can be considered a stable mile stone for most users, and **b)** macOS native icons and labels are maintained.<br/>  Alternatively you can download the repo at it's current "0-day" state if you see that's more recent than the latest release date and contains one or more updates you are looking for via the green "Clone or Download" button on the top right of the [repo's main page](https://github.com/tctien342/Asus-Vivobook-S510UA-Hackintosh), "Download ZIP". Consider the non-release state as BETA, and be aware that GitHub does ***not*** (yet?) sustain macOS native icons and labels in its open repo!
2. Open the folder "**post macOS Installations**" and install *all* from within its subfolders for Hibernate prevention, additional function keys, etc. Also (strongly recommended!) study and consider the content of the folder [Optional]!
3. **Fill your internal hard disk's EFI partition with the OC or Clover EFI folder**. You can use the matching Configurator to mount your system ESP (EFI System Partition). Next back up the existing System EFI folder and copy one of this release's EFI folders to your system's ESP.
4. **OpenCore Configurator**:
    * click onto **PlatformInfo** in the side bar on the left
    * on the right top, click onto the 1st tab 'DataHub - Generic - PlatformNVRAM'. You will see four text fields with `update this field`
    * *If you are a new user w/o a previous Clover config.plist*: while leaving the current instance open in the background, open a new empty instance of OC, navigate to the same tab, click onto the up/down arrow box next to `Check Coverage` and choose `MacBookPro15,4`
    * in the provided OC config.plist in the 1st window, fill ONLY the text fields reading `update this field` with the corresponding values from the 2nd window instance
    * *existing user*: if you have already been booting via Clover config.plist: copy the matching values over according to [these conversion translations](https://dortania.github.io/OpenCore-Install-Guide/clover-conversion/Clover-config.html#smbios)
    * save
 
    **Clover Configurator**:
    
    * *new user*: click onto **SMBIOS** in the side bar on the left. Under 'System', next to 'Serial Number', click onto the `Generate New` button. That will change both, system and board serial number.
    * *existing user*: use (recommended) [PrefEdit](https://www.bresink.com/osx/PrefEdit.html) to first remove the dummy SMBIOS section and replace it with your existing one
    * Save.

 Above steps are necessary to - amongst other things - hopefully enable the use of iCloud.

5. **Reboot and ENJOY :)**


# Wi-Fi Replacement

As of 2021-02-23 there is still no fully working macOS driver for the `Intel AC 8265 M.2` card - progress see at [OpenIntelWireless](https://github.com/OpenIntelWireless). Therefore best replace it, preferably with a [Fenvi BCM94360NG](https://www.google.com/search?btnG=Search&q=Fenvi+BCM94360NG+M.2) because it has macOS native Wi-Fi and Bluetooth chipset and IDs. If you do so, you can/ should:

- remove *ALL* related kexts from inside your EFI folder(s) (`AirportBrcmFixup`, `BrcmBluetoothInjector`, `BrcmFirmwareData`, `BrcmPatchRAM2`, `BrcmPatchRAM3`)
- remove *ALL* related entries (brcmfx-country=US bpr_postresetdelay=400 bpr_initialdelay=400 bpr_probedelay=200) from your config.plist(s):

  **OC:** NVRAM -> 7C436110-AB2A-4BBB-A880-FE41995C9F82 -> boot-args</br>
  **Clover:** Boot > Arguments (remove via the `-`)

- save and reboot

Alternatively you can use a [Dell DW1560](https://www.google.com/search?btnG=Search&q=Dell+DW1560+M.2) or a [Lenovo FRU 04X6020](https://www.google.com/search?btnG=Search&q=Lenovo+FRU+04X6020+M.2) (or even a different kind if you can find a better one). If you opt for one of these, you should adapt the boot argument `brcmfx-country=US` to match your country code. Example: `brcmfx-country=DE` for Germany, `VN` for Vietnam etc. You find it at the same spot(s) as described above.

# _ATTENTION - be careful with Updates_!
1. **Clover only**: after updating `AirportBrcmFixup.kext` and/or `VoodooPS2Controller.kext` and (esp.) if you're running Big Sur, you ***have to*** (!!) run `/EFI/CLOVER/kexts/Other/remove problematic kexts after update` or Big Sur won't boot. See [here](https://github.com/CloverHackyColor/CloverBootloader/issues/350) for the sad and stubborn details...
2. **VirtualSMC**: The VirtualSMC version should match those of accompanying plugin kexts (**SMCProcessor**, **SMCBatteryManager**) to avoid touchpad and battery issues! Please make sure you download the most recent stable release of the **complete** SMC package [from its repo](https://github.com/acidanthera/VirtualSMC/releases) and replace ***each*** existing file with the matching new one.

# Recommendations
1. **OC (1st) + Clover (2nd)**: On your SSD's ESP, have OC's EFI folder so OC is your main bootloader; additionally create a separate FAT partition with at least 50+ MB, label it `Clover` and copy the Clover EFI folder onto it and onfigure it accdg. to above instructions. Make sure you use the same SMBIOS Platform Info in both config.plists so you don't experience oddities!
2. **Downscale monitor resolution to 1600 x 900** for two reasons: **a)** you will need to squint much less or ideally not at all because human eyes are simply not made for a 1920 x 1080 resolution on a 15,6" screen, period; and b) your monitor will use less energy = longer battery life!
3. **Sound quality** isn't great because the speakers are mediocre in general, and to make things even worse, Asus placed them into the bottom of the case, mostly facing down. For tips to improve the sound, please look at "[docs/BetterSound.html](https://htmlpreview.github.io/?https://github.com/tctien342/Asus-Vivobook-S510UA-Hackintosh/blob/master/docs/BetterSound.html)"

# Fine-tuning
- **Clover**: [how to create a GUI custom entry for Big Sur](https://github.com/CloverHackyColor/CloverBootloader/issues/300#issuecomment-768300847) rather than 'Boot Big Sur from PreBoot'
- When all is working fine for you and you prefer not to look at all the lines flashing by during boot, **remove the `-v` verbose mode** switch:<br>
**OC**: NVRAM > 7C436110-AB2A-4BBB-A880-FE41995C9F82 > boot-args<br>
**Clover**: Boot > Arguments
- Want to edit your VivoBook's U**EFI BIOS boot menu**? The simplest and quickest tool I found is the Windows freeware [BootIce](https://www.softpedia.com/get/System/Boot-Manager-Disk/Bootice.shtml), regardless of its age: [UEFI > Edit boot entries](https://www.google.com/search?q=BootIce+UEFI+Edit+boot+entries&tbm=isch&ved=2ahUKEwjPjeOrmovvAhUYG-wKHamZDVoQ2-cCegQIABAA&oq=BootIce+UEFI+Edit+boot+entries&gs_lcp=CgNpbWcQAzoECCMQJzoECAAQGDoECAAQHlCXlANYmpUEYK63BGgDcAB4AIABX4gBxg-SAQIyN5gBAKABAaoBC2d3cy13aXotaW1nwAEB&sclient=img&ei=AdQ6YI-JMpi2sAeps7bQBQ&bih=908&biw=1680)

# Troubleshooting
**Many issues can be solved by performing a NVRAM Reset**, in OC via the last entry in the boot menu picker, and in Clover Boot menu by pressing F11! Note that this will also clear custom boot entries in your UEFI BIOS boot menu.

- [[SOLVED] Sporadic black screen on wake from sleep](https://github.com/tctien342/Asus-Vivobook-S510UA-High-Sierra-10.13-Hackintosh/issues/41)
- [[SOLVED] VivoBook doesn't go to sleep properly on low battery but rather crashes](https://github.com/tctien342/Asus-Vivobook-S510UA-Hackintosh/issues/39)
- [[SOLVED] VivoBook won't wake from sleep](https://github.com/tctien342/Asus-Vivobook-S510UA-Hackintosh/issues/54#issuecomment-612618529)
- [[SOLVED] i5-8250U 1.60GHz CPU in 'About this Mac' & Sys Profiler displayed as i7 1.8GHz](https://github.com/acidanthera/bugtracker/issues/1515)

_________________________
## Special Credits for this repo to these fellow hackintoshers:
**whatnameisit**: main contributor; maintainer of the [VivoBook X510UA-BQ490 repo](https://github.com/whatnameisit/Asus-Vivobook-X510UA-BQ490-Hackintosh/) | **tctien342**: originator of this VivoBook S15 repo ([archived](https://github.com/tctien342/Asus-Vivobook-S510UA-Hackintosh/releases)) | **hieplpvip**: originator of the underlying/ upstream [ZenBook repo](https://github.com/hieplpvip/Asus-Zenbook-Hackintosh) and [AsusSMC](https://github.com/hieplpvip/AsusSMC); contributor | **[fewtarius](https://github.com/fewtarius)**: facilitator | To [many](https://github.com/whatnameisit/Asus-Vivobook-X510UA-BQ490-Hackintosh/blob/master/README.md#credits) *MANY* others .........
