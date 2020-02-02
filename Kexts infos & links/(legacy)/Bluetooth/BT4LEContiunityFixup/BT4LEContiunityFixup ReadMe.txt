BT4LEContiunityFixup

An open source kernel extension providing patches for IOBluetoothFamily

Features:
    This tool makes the necessary changes to enable OS X 10.10 and 10.11 Continuity Features on compatible hardware. Continuity Features activated by this patch include Handoff, Instant Hotspot, and New Airdrop. OS X 10.11 (El Capitan) dongle support is not stable yet! (https://github.com/dokterdok/Continuity-Activation-Tool/)

Boot-args:
    -bt4lefxoff disables kext loading
    -bt4lefxdbg turns on debugging output
    -bt4lefxbeta enables loading on unsupported OS X

Credits:
    - Apple for macOS
    - vit9696 for Lilu.kext
    - Sherlocks for the idea & testing
    - dokterdok for patch
    - lvs1974 for writing the software and maintaining it
