# Asus Vivobook S510UA

This build running on MacOs X

![Alt text](https://ivanov-audio.com/wp-content/uploads/2014/01/Hackintosh-Featured-Image.png)

# Detail

    Version:    9
    Date:       06/03/2019
    Support:    All BIOS
    Changelogs:
        - Fixed BIOS 309
        - Optimize kext and hotpatch (Ported from ZENBOOK by hieplpvip)
        - HDMI include sound, SDcard work
        - Fixed slow input password by using SMBIOS 11,1
    Status: Stable

# System specification

    1.Name:           Asus Vivobook S510UA BQ414T
    2.CPU:            Intel Core i5-8250U
    3.Graphic:        Intel UHD620
    4.Wifi:           Intel Dual Band Wireless-AC 8265 - with bluetooth // REPLACED WITH DW1560 (AirDrop and Handoff Working perfectly)
    5.Card Reader:    Realtek_CardReader(RTL8411B_RTS5226_RTS5227)
    6.Camera:         ASUS UVC HD
    7.Audio:          Conexant Audio CX8050
    8.Touchpad:       ELAN1300
    9.Bios Version:   301/303

# Thing will not able to use

    1. DGPU like 940MX
    2. Fingerprint
    3. FN + media controller's key

# Know problems

    1.  None

# New VoodooI2C

    -Git: [VoodooI2C ASUS @hieplpvip](https://github.com/hieplpvip/VoodooI2C)

# Step to install

    1. Prepair an Mac installer in USB with Clover added ( Use unibeast to create it )
    2. Replace EFI folder in USB EFI partition with this INCLUDED EFI FOLDER (EFI BQ414T and EFI OTHER)
    3. Boot into USB and select MacOs installer
    4. First boot Trackpad will not work, need and mouse connect through USB, Follow mac install instruction you can find it on tonymacx86 or other hackintosh forum
    5. After install success, boot into MacOS, Copy Kext In EFI OTHER or EFI BQ414T -> L/E to /Library/Extension
    6. Use Kext Utility to rebuild kext then reboot
    7. This time trackpad and audio will working normally, then you need to use Clover EFI bootloader to install clover to EFI partition
    8. After install success, using Clover Configurator to mount your USB EFI partition then copy it to your System EFI.
    9. After System EFI replaced by your EFI, Using Clover Configurator to change SMBIOS, generate your serial and MBL, then you can use icloud now
    10. Enjoy

# WIFI Replacement

    1. Replace your card wifi with DW1560 (Or other if you can find better one)
    2. Copy two kext on DW1560 -> Clover to System EFI -> Clover -> Kext -> Other
    3. Copy DW1560 -> L/E kexts to /Library/Extension folder then rebuild kext with Kext Utility
    4. Reboot and enjoy
