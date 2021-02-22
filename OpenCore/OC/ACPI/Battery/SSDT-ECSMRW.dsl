// This example includes breaking up SystemMemory OperationRegion FieldUnitObjs.
// Both EC and SM OperationRegions share the same methods, but are differentiated by assigning EBCR or STMR. 
// I have changed the Argument sequence a lot, so be careful when actually using this work.
// Read the comments to understand what is being done.
// If you just want to use them, read HOWR and HOWW.

DefinitionBlock ("", "SSDT", 2, "what", "ECSMRW", 0x00000000)
{
    External (_SB_.PCI0.LPCB.EC0_, DeviceObj)

    Scope (\_SB.PCI0.LPCB.EC0)
    {
        Scope (\)
        {
            Name (EBCR, One) // Object assigned to EmBeddedContRoller
            Name (STMR, Zero) // Object assigned to SysTemMemoRy
        }

        Method (RSTO, 2, NotSerialized) // Temporary store method for Read.
        {
            If (Arg1 = \EBCR) // If it is EC
            {
                OperationRegion (ECRD, EmbeddedControl, Arg0, One) // define an EC OperationRegion
                Field (ECRD, ByteAcc, NoLock, Preserve)
                {
                    BYTE,   8
                }

                Return (BYTE) /* \_SB_.PCI0.LPCB.EC0_.RSTO.BYTE */ // and read a FieldUnitObj one-by-one torn down in RXCT.
            }
            ElseIf (Arg1 = \STMR) // If it is SM
            {
                OperationRegion (SMRD, SystemMemory, Arg0, One) // define a SM OperationRegion
                Field (SMRD, ByteAcc, NoLock, Preserve)
                {
                    BYTS,   8
                }

                Return (BYTS) /* \_SB_.PCI0.LPCB.EC0_.RSTO.BYTS */ // and read a FieldUnitObj one-by-one torn down in RXCT.
            }
            Else
            {
                Return (Zero) // Return 0 on if RCXT is not correctly executed.
            }
        }

        Method (RXCT, 4, Serialized) // Execute Read. The order of the Arguments can be found in HOWR.
        {
            Arg2 = ((Arg2 + 0x07) >> 0x03)
            Name (TEMP, Buffer (Arg2){})
            Arg2 += Arg1
            Local0 = Zero
            While ((Arg1 < Arg2))
            {
                TEMP [Local0] = RSTO ((Arg0 + Arg1), Arg3)
                Arg1++
                Local0++
            }

            Return (TEMP) /* \_SB_.PCI0.LPCB.EC0_.RXCT.TEMP */
        }

        Name (HOWR, Package (0x02) // How-to-read order. Preserve this information so no one will whine about forgetting how to use new methods.
        {
            "RXCT (OperationRegion Offset, FieldUnitObj Offset, FieldUnitObj Length, EmbeddedControl or SystemMemory)", // Written out
            "RXCT (0x18, 0x04, 256, EBCR)" // Example
        })
        Method (WSTO, 3, NotSerialized) // Temporary store method for Write.
        {
            If (Arg2 = \EBCR) // If it is EC
            {
                OperationRegion (ECWT, EmbeddedControl, Arg0, One) // define an EC OperationRegion
                Field (ECWT, ByteAcc, NoLock, Preserve)
                {
                    BYTE,   8
                }

                BYTE = Arg1 // and write the value to FieldUnitObj one-by-one torn down in WXCT.
            }
            ElseIf (Arg2 = \STMR) // If it is SM
            {
                OperationRegion (SMWT, SystemMemory, Arg0, One) // define a SM OperationRegion
                Field (SMWT, ByteAcc, NoLock, Preserve)
                {
                    BYTS,   8
                }

                BYTS = Arg1 // and write the value to FieldUnitObj one-by-one torn down in WXCT.
            }
            Else
            { // Do nothing if WXCT is not correctly executed.
            }
        }

        Method (WXCT, 5, Serialized) //Execute Write. The order of the Arguments can be found in HOWW.
        {
            Arg2 = ((Arg2 + 0x07) >> 0x03)
            Name (TEMP, Buffer (Arg2){})
            TEMP = Arg3
            Arg2 += Arg1
            Local0 = Zero
            While ((Arg1 < Arg2))
            {
                WSTO ((Arg0 + Arg1), DerefOf (TEMP [Local0]), Arg4)
                Arg1++
                Local0++
            }
        }

        Name (HOWW, Package (0x02) // How-to-write order. Preserve this information so no one will whine about forgetting how to use new methods.
        {
            "WXCT (OperationRegion Offset, FieldUnitObj Offset, FieldUnitObj Length, Value written to FieldUnitObj, EmbeddedControl or SystemMemory)",  // Written out
            "WXCT (0x2A, 0x0A, 64, Arg2, STMR)" // Example
        })
    }
}

