## Release v.11.0, Feb. 28 2021

- added Big Sur compatible OpenCore EFI (credits to whannameisit)
- added Big Sur compatible Clover EFI based on whannameisit's OC EFI
- updated all kexts and drivers
- overall overhaul, improvements and refinements to the entire repo
- moved repo over from tctien342 to my github corner

____________________

### 2020-04-10:
- assigned real country code (US) across all config plist files to Boot/Arguments/brcmfx-country so Wi-Fi networks get detected even w/o any edit (user is still encouraged to set desired country code)


## Release v.10.0, Feb. 24 2020

It contains (among others) the following changes:

### Fixes & Improvements:

- [[SOLVED] lag in authentication dialogs (as well as a delayed login screen)/ more appropriate SMBIOS product model](https://github.com/tctien342/Asus-Vivobook-S510UA-High-Sierra-10.13-Hackintosh/issues/40)
- [[SOLVED] sporadic black screen on wake from sleep](https://github.com/tctien342/Asus-Vivobook-S510UA-High-Sierra-10.13-Hackintosh/issues/41)
- [[SOLVED] keyboard backlight across all current macOS 10.13/14/15](https://github.com/tctien342/Asus-Vivobook-S510UA-High-Sierra-10.13-Hackintosh/issues/44)
- [[OPTION] Touchpad: possibly smoother more reliable overall experience with custom polling mode SSDT](https://github.com/tctien342/Asus-Vivobook-S510UA-High-Sierra-10.13-Hackintosh/issues/43)
- [[IMPROVED/ OPTION] Touchpad: smoother more reliable 2-finger operations with custom VoodooI2C v.2.0.3](https://github.com/tctien342/Asus-Vivobook-S510UA-High-Sierra-10.13-Hackintosh/issues/42)
- [[IMPROVED] SSDT-less USB ports approach for better Bluetooth compatibility](https://github.com/tctien342/Asus-Vivobook-S510UA-High-Sierra-10.13-Hackintosh/issues/45)
- [IMPROVED] Clover config, Kernel and Kext Patches: deactivated 'Kernel LAPIC' and 'Kernel PM', enabled 'TRIM for SSD' (for details read through [EFI pre-v.10.0 for Asus Vivobook S15](https://github.com/tctien342/Asus-Vivobook-S510UA-Hackintosh/issues/46))

### Also see:

- [[STICKY]: TOUCHPAD » consolidated links to related issues](https://github.com/tctien342/Asus-Vivobook-S510UA-Hackintosh/issues/48)

### Optional:

- [[SOLVED] VivoBook doesn't go to sleep properly on low battery but rather crashes](https://github.com/tctien342/Asus-Vivobook-S510UA-Hackintosh/issues/39)


