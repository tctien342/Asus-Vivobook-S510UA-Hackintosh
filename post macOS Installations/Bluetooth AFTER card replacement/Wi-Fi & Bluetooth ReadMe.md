#_Wi-Fi & Bluetooth_

For working Wi-Fi, Bluetooth and continuity features, the following kexts need to be present. The instructions apply to both, DW1560 and FRU 04X6020. For the least memory footprint it is recommeneded to (rather than BrcmFirmwareData.kext) use **BrcmFirmwareRepo**.kext. It does ***not work*** from E/C/k/O (EFI/CLOVER/kexts/Other) but ***must*** be installed to L/E (/Library/Extensions). Accordingly, ***any other*** necessary kext(s) from the BrcmPatchRAM package ***must*** be installed to L/E, too, and ***removed from E/C/k/O***, for most reliable functionality!


### Mojave, High Sierra:  
- **E/C/k/O**: AirportBrcmFixup.kext  
- **L/E**: BrcmFirmwareRepo.kext, BrcmPatchRAM**2**.kext  

### Catalina:
- **E/C/k/O**: AirportBrcmFixup.kext  
- **L/E**: BrcmFirmwareRepo.kext, BrcmPatchRAM**3**.kext, **BrcmBluetoothInjector.kext**  

### Notes:

1. As per recommendations, any kext incl. **AirportBrcmFixup**.kext also works as supposed if installed to L/E.


2. Neither the **DW1560** nor the F**RU 04X6020** need:

- BT4LEContinuityFixup.kext
- FakePCIID.kext
- FakePCIID\_Broadcom_Wifi.kext

**Infos credits**: whatnameisit, acidanthera, ReHabMan, Lee Binder

________________

###Excerpts from/ digest of https://github.com/acidanthera/BrcmPatchRAM

#### System Requirements:

- **BrcmPatchRAM.kext**: 10.10 or earlier
- **BrcmPatchRAM2.kext**: 10.11 - 10.14
- **BrcmPatchRAM3.kext**: 10.15
- **BrcmFirmwareRepo.kext**: 10.15 or earlier. **ATTENTION**:     
	* ***must*** be installed to L/E because it cannot be injected by a bootloader!
	* if this kext is used, any accompanying kext()s (one of the BrcmPatchRAM; BrcmBluetoothInjector) ***must*** be installed to L/E, too, for optial reliability!
- **BrcmBluetoothInjector.kext**: 10.11 or later. Do NOT use BrcmPatchRAM or BrcmPatchRAM2 with this kext - they MUST be removed!

#### Details:

The **BrcmBluetoothInjector**.kext is a codeless kernel extension which injects the BT hardware data using a plist; it does not contain a firmware uploader. You might want to try this kext as stand-alone first if you wish to see if your device will work without a firmware uploader.

#### Instructions for macOS Catalina:

If you need to use **BrcmPatchRAM3**.kext (for macOS Catalina only), it requires **BrcmBluetoothInjector**.kext in addition, as changes in 10.15.x require the use of a separate injector kext. This is due to the removal of the following IOCatalogue methods:

*IOCatalogue::addDrivers, IOCatalogue::removeDrivers* and *IOCatalogue::startMatching*

Consequently, to have the native BT driver load for the device (BroadcomBluetoothHostControllerUSBTransport), we inject using a plist with a slightly lower IOProbeScore than BrcmPatchRAM3 so it doesn't probe before the firmware upload.

#### Instructions for macOS Mojave and High Sierra:

If you use BrcmFirmwareRepo AND BrcmPatchRAM2, you ***must*** remove BrcmBluetoothInjector.kext because it conflicts with BrcmPatchRAM2. Make sure it is ***not*** present in either L/E or in E/C/k/O!