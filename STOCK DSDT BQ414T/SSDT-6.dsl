/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20161210-64(RM)
 * Copyright (c) 2000 - 2016 Intel Corporation
 * 
 * Disassembling to non-symbolic legacy ASL operators
 *
 * Disassembly of SSDT-6.aml, Wed Apr 11 16:18:44 2018
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x00000517 (1303)
 *     Revision         0x02
 *     Checksum         0x61
 *     OEM ID           "INTEL "
 *     OEM Table ID     "TbtTypeC"
 *     OEM Revision     0x00000000 (0)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20160422 (538313762)
 */
DefinitionBlock ("", "SSDT", 2, "INTEL ", "TbtTypeC", 0x00000000)
{
    /*
     * External declarations were imported from
     * a reference file -- refs.txt
     */

    External (_GPE.MMTB, MethodObj)    // Imported: 0 Arguments
    External (_GPE.VHOV, MethodObj)    // Imported: 3 Arguments
    External (_SB_.PCI0.GFX0.DD02._BCM, MethodObj)    // Imported: 1 Arguments
    External (_SB_.PCI0.LPCB.H_EC.ECMD, MethodObj)    // Imported: 1 Arguments
    External (_SB_.PCI0.LPCB.H_EC.ECRD, MethodObj)    // Imported: 1 Arguments
    External (_SB_.PCI0.LPCB.H_EC.ECWT, MethodObj)    // Imported: 2 Arguments
    External (_SB_.PCI0.PEG0.PEGP.SGPO, MethodObj)    // Imported: 2 Arguments
    External (_SB_.PCI0.RP01.PXSX, DeviceObj)    // (from opcode)
    External (_SB_.PCI0.RP09.PXSX, DeviceObj)    // (from opcode)
    External (_SB_.PCI0.SAT0.SDSM, MethodObj)    // Imported: 4 Arguments
    External (_SB_.PCI0.XHC_.RHUB.TPLD, MethodObj)    // Imported: 2 Arguments
    External (MDBG, MethodObj)    // Imported: 1 Arguments
    External (TBSE, IntObj)    // (from opcode)
    External (TBTS, IntObj)    // (from opcode)
    External (UPT1, IntObj)    // (from opcode)
    External (UPT2, IntObj)    // (from opcode)
    External (USME, IntObj)    // (from opcode)

    If (LAnd (LEqual (TBTS, One), LEqual (TBSE, One)))
    {
        Scope (\_SB.PCI0.RP01.PXSX)
        {
            Name (TUSB, Package (0x02)
            {
                One, 
                0x04
            })
            Device (TBDU)
            {
                Name (_ADR, 0x00020000)  // _ADR: Address
                Device (XHC)
                {
                    Name (_ADR, Zero)  // _ADR: Address
                    Device (RHUB)
                    {
                        Name (_ADR, Zero)  // _ADR: Address
                        Method (TPLD, 2, Serialized)
                        {
                            Name (PCKG, Package (0x01)
                            {
                                Buffer (0x10) {}
                            })
                            CreateField (DerefOf (Index (PCKG, Zero)), Zero, 0x07, REV)
                            Store (One, REV)
                            CreateField (DerefOf (Index (PCKG, Zero)), 0x40, One, VISI)
                            Store (Arg0, VISI)
                            CreateField (DerefOf (Index (PCKG, Zero)), 0x57, 0x08, GPOS)
                            Store (Arg1, GPOS)
                            CreateField (DerefOf (Index (PCKG, Zero)), 0x4A, 0x04, SHAP)
                            Store (One, SHAP)
                            CreateField (DerefOf (Index (PCKG, Zero)), 0x20, 0x10, WID)
                            Store (0x08, WID)
                            CreateField (DerefOf (Index (PCKG, Zero)), 0x30, 0x10, HGT)
                            Store (0x03, HGT)
                            Return (PCKG)
                        }

                        Method (TUPC, 2, Serialized)
                        {
                            Name (PCKG, Package (0x04)
                            {
                                One, 
                                Zero, 
                                Zero, 
                                Zero
                            })
                            Store (Arg0, Index (PCKG, Zero))
                            Store (Arg1, Index (PCKG, One))
                            Return (PCKG)
                        }

                        Device (HS01)
                        {
                            Name (_ADR, One)  // _ADR: Address
                            Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                            {
                                If (LEqual (USME, Zero))
                                {
                                    Return (TUPC (One, 0x08))
                                }
                                Else
                                {
                                    Return (TUPC (Zero, Zero))
                                }
                            }

                            Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                            {
                                If (LEqual (USME, Zero))
                                {
                                    Return (TPLD (One, One))
                                }
                                Else
                                {
                                    Return (TPLD (Zero, Zero))
                                }
                            }
                        }

                        Device (HS02)
                        {
                            Name (_ADR, 0x02)  // _ADR: Address
                            Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                            {
                                If (LEqual (USME, Zero))
                                {
                                    Return (TUPC (One, 0x08))
                                }
                                Else
                                {
                                    Return (TUPC (Zero, Zero))
                                }
                            }

                            Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                            {
                                If (LEqual (USME, Zero))
                                {
                                    Return (TPLD (One, 0x02))
                                }
                                Else
                                {
                                    Return (TPLD (Zero, Zero))
                                }
                            }
                        }

                        Device (SS01)
                        {
                            Name (_ADR, 0x03)  // _ADR: Address
                            Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                            {
                                Return (TUPC (One, 0x09))
                            }

                            Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                            {
                                If (LEqual (USME, Zero))
                                {
                                    Return (TPLD (One, One))
                                }
                                Else
                                {
                                    Return (TPLD (One, UPT1))
                                }
                            }
                        }

                        Device (SS02)
                        {
                            Name (_ADR, 0x04)  // _ADR: Address
                            Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                            {
                                Return (TUPC (One, 0x09))
                            }

                            Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                            {
                                If (LEqual (USME, Zero))
                                {
                                    Return (TPLD (One, 0x02))
                                }
                                Else
                                {
                                    Return (TPLD (One, UPT2))
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    If (LAnd (LEqual (TBTS, One), LEqual (TBSE, 0x09)))
    {
        Scope (\_SB.PCI0.RP09.PXSX)
        {
            Name (TUSB, Package (0x02)
            {
                One, 
                0x02
            })
            Device (TBDU)
            {
                Name (_ADR, 0x00020000)  // _ADR: Address
                Device (XHC)
                {
                    Name (_ADR, Zero)  // _ADR: Address
                    Device (RHUB)
                    {
                        Name (_ADR, Zero)  // _ADR: Address
                        Method (TPLD, 2, Serialized)
                        {
                            Name (PCKG, Package (0x01)
                            {
                                Buffer (0x10) {}
                            })
                            CreateField (DerefOf (Index (PCKG, Zero)), Zero, 0x07, REV)
                            Store (One, REV)
                            CreateField (DerefOf (Index (PCKG, Zero)), 0x40, One, VISI)
                            Store (Arg0, VISI)
                            CreateField (DerefOf (Index (PCKG, Zero)), 0x57, 0x08, GPOS)
                            Store (Arg1, GPOS)
                            CreateField (DerefOf (Index (PCKG, Zero)), 0x4A, 0x04, SHAP)
                            Store (One, SHAP)
                            CreateField (DerefOf (Index (PCKG, Zero)), 0x20, 0x10, WID)
                            Store (0x08, WID)
                            CreateField (DerefOf (Index (PCKG, Zero)), 0x30, 0x10, HGT)
                            Store (0x03, HGT)
                            Return (PCKG)
                        }

                        Method (TUPC, 2, Serialized)
                        {
                            Name (PCKG, Package (0x04)
                            {
                                One, 
                                Zero, 
                                Zero, 
                                Zero
                            })
                            Store (Arg0, Index (PCKG, Zero))
                            Store (Arg1, Index (PCKG, One))
                            Return (PCKG)
                        }

                        Device (HS01)
                        {
                            Name (_ADR, One)  // _ADR: Address
                            Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                            {
                                If (LEqual (USME, Zero))
                                {
                                    Return (TUPC (One, 0x08))
                                }
                                Else
                                {
                                    Return (TUPC (Zero, Zero))
                                }
                            }

                            Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                            {
                                If (LEqual (USME, Zero))
                                {
                                    Return (TPLD (One, One))
                                }
                                Else
                                {
                                    Return (TPLD (Zero, Zero))
                                }
                            }
                        }

                        Device (HS02)
                        {
                            Name (_ADR, 0x02)  // _ADR: Address
                            Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                            {
                                If (LEqual (USME, Zero))
                                {
                                    Return (TUPC (One, 0x08))
                                }
                                Else
                                {
                                    Return (TUPC (Zero, Zero))
                                }
                            }

                            Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                            {
                                If (LEqual (USME, Zero))
                                {
                                    Return (TPLD (One, 0x02))
                                }
                                Else
                                {
                                    Return (TPLD (Zero, Zero))
                                }
                            }
                        }

                        Device (SS01)
                        {
                            Name (_ADR, 0x03)  // _ADR: Address
                            Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                            {
                                Return (TUPC (One, 0x09))
                            }

                            Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                            {
                                If (LEqual (USME, Zero))
                                {
                                    Return (TPLD (One, One))
                                }
                                Else
                                {
                                    Return (TPLD (One, UPT1))
                                }
                            }
                        }

                        Device (SS02)
                        {
                            Name (_ADR, 0x04)  // _ADR: Address
                            Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                            {
                                Return (TUPC (One, 0x09))
                            }

                            Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                            {
                                If (LEqual (USME, Zero))
                                {
                                    Return (TPLD (One, 0x02))
                                }
                                Else
                                {
                                    Return (TPLD (One, UPT2))
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

