# Battery: Modified RECB and WECB methods
by whatnameis | [link to original README.md](https://github.com/whatnameisit/Asus-Vivobook-X510UA-BQ490-Hackintosh/blob/master/OC/ACPI/README.md)
## Problem
I was studying the [_new_ battery patch guide](https://xstar-dev.github.io/hackintosh_advanced/Guide_For_Battery_Hotpatch.html) and was wondering if there was a simpler way of reading and writing `FieldUnitObjs` with size above 32 bits.\
There are many databases which contain battery patches for various laptops, but they are not very consistent when breaking up `FieldUnitObjs` size above 32 bits. If the `OperationRegion` starts at `Zero`, then they use `RE1B` and `RECB` (or `WE1B` and `WECB`. I should inclusively call them `xE1B` and `xECB`.) methods. If it starts at something other than `Zero`, then they break up `256` bits into a set of 32 `FieldUnitObjs` and write every single one of them into `xRBA` methods. A lack of a unified guide, and also tiring to rewrite all the broken down `FieldUnitObjs`...\
The [_new_ battery patch guide](https://xstar-dev.github.io/hackintosh_advanced/Guide_For_Battery_Hotpatch.html) talks about how `SystemMemory` `OperationRegions` also need patching and there it says this:
```
注意

有些笔记本的 EC 使用 SystemMemory 作用域，则 EC、RE1B 和 WE1B 的 Field 起始偏移量也需要加上原始定义数值，参照如下所示代码进行修改
```
English translation:
```
note

Some notebook EC use SystemMemoryscope, EC, RE1B and WE1B the Field starting offset is also necessary to add the value originally defined with reference to the code to be modified as shown below
```
```
Scope (_SB.PCI0.LPCB.EC0)
{
    OperationRegion (ERAX, SystemMemory, 0xFE708300, 0x0100)
    Field (ERAX, ByteAcc, Lock, Preserve)
    {
    ···
    Method (RE1B, 1, NotSerialized)
    {
        Local0 = (0xFE708300 + Arg0)
        OperationRegion (ERM2, SystemMemory, Local0, One)
```
Notice how they summed the `Offsets` of the `OperationRegion` and the `FieldUnitObj`. The same should apply to `EmbeddedControl` `OperationRegion`.  Just write a set of `xE1B` and `xECB` methods with added `Offsets`! But I have to be smarter. I do not want to define a new set of methods every time a different `OperationRegion` `Offset` shows up that requires patching.
## Preliminary work
These are the usual methods to read and write to larger-sized `FieldUnitObjs`:
```
Method (RE1B, 1, NotSerialized)
{
    OperationRegion (ERM2, EmbeddedControl, Arg0, One)
    Field (ERM2, ByteAcc, NoLock, Preserve)
    {
        BYTE,   8
    }

    Return (BYTE) /* \_SB_.PCI0.LPCB.EC0_.RE1B.BYTE */
}

Method (RECB, 2, Serialized)
{
    Arg1 = ((Arg1 + 0x07) >> 0x03)
    Name (TEMP, Buffer (Arg1){})
    Arg1 += Arg0
    Local0 = Zero
    While ((Arg0 < Arg1))
    {
        TEMP [Local0] = RE1B (Arg0)
        Arg0++
        Local0++
    }

    Return (TEMP) /* \_SB_.PCI0.LPCB.EC0_.RECB.TEMP */
}

Method (WE1B, 2, NotSerialized)
{
    OperationRegion (ERAM, EmbeddedControl, Arg0, One)
    Field (ERAM, ByteAcc, NoLock, Preserve)
    {
        BYTE,   8
    }

    BYTE = Arg1
}

Method (WECB, 3, Serialized)
{
    Arg1 = ((Arg1 + 0x07) >> 0x03)
    Name (TEMP, Buffer (Arg1){})
    TEMP = Arg2
    Arg1 += Arg0
    Local0 = Zero
    While ((Arg0 < Arg1))
    {
        WE1B (Arg0, DerefOf (TEMP [Local0]))
        Arg0++
        Local0++
    }
}
```
So let's modify these methods so we can let the computer do all the work and not us. I think it should be very simple. I just need to include the `OperationRegion` `Offset` as a `Variable`. Since the `xECB` methods pass the `FieldUnitObj` `Offset` from its own `Arg0` to `xE1B` methods as the `first` `Argument`, adding the `OperationRegion` `Offset` to `xECB`'s `Arg0` and then passing it would suffice.\
Increase the number of `Arguments` to `xECB` methods by `1` in their headers:
```
...
Method (RECB, 3, Serialized)
...
Method (WECB, 4, Serialized)
...
```
And add the last `Argument` to `Arg0`
```
...
Method (RECB, 3, Serialized)
{
...
        TEMP [Local0] = RE1B ((Arg0 + Arg2))
...
}
...
Method (WECB, 4, Serialized)
{
...
        WE1B ((Arg0 + Arg3), DerefOf (TEMP [Local0]))
...
}
...
```
Then remember to write the `OperationRegion` `Offset` in the last `Argument`.\
But the order is messy. Let's rearrange the `Arguments` so that it makes sense:
```
RECB (OperationRegion Offset, FieldUnitObj Offset, FieldUnitObj Length)
WECB (OperationRegion Offset, FieldUnitObj Offset, FieldUnitObj Length, Value written to FieldUnitObj)
```
To do so, swap the `Arguments`:
- `FieldUnitObj` `Offset` `Arg0` to `Arg1` for `Read` and `Write`
- `FieldUnitObj` `Length` `Arg1` to `Arg2` for `Read` and `Write`
- `OperationRegion` `Offset` `Arg2` for `Read` and `Arg3` for `Write` to `Arg0`
- `Value` written to `FieldUnitObj` `Arg2` to `Arg3` for `Write`
Then you should have this:
```
Method (RECB, 3, Serialized)
{
    Arg2 = ((Arg2 + 0x07) >> 0x03)
    Name (TEMP, Buffer (Arg2){})
    Arg2 += Arg1
    Local0 = Zero
    While ((Arg1 < Arg2))
    {
        TEMP [Local0] = RE1B ((Arg0 + Arg1))
        Arg1++
        Local0++
    }

    Return (TEMP) /* \_SB_.PCI0.LPCB.EC0_.RECB.TEMP */
}
...
Method (WECB, 4, Serialized)
{
    Arg2 = ((Arg2 + 0x07) >> 0x03)
    Name (TEMP, Buffer (Arg1){})
    TEMP = Arg3
    Arg2 += Arg1
    Local0 = Zero
    While ((Arg1 < Arg2))
    {
        WE1B ((Arg0 + Arg1), DerefOf (TEMP [Local0]))
        Arg1++
        Local0++
    }
}

```
Now we are good to go!
## Application
In this ASUS laptop, there is only one `FieldUnitObj` we need to work on. In `DSDT`, 256-bit `BDAT` object in one of its `EmbeddedControl` `OperationRegions`:
```
OperationRegion (SMBX, EmbeddedControl, 0x18, 0x28)
Field (SMBX, ByteAcc, NoLock, Preserve)
{
    PRTC,   8, 
    SSTS,   5, 
        ,   1, 
    ALFG,   1, 
    CDFG,   1, 
    ADDR,   8, 
    CMDB,   8, 
    BDAT,   256, 
    BCNT,   8, 
        ,   1, 
    ALAD,   7, 
    ALD0,   8, 
    ALD1,   8
}
```
tctien342 and hieplpvip were kind to us and broke this whole thing into 32 `FieldUnitObjs` and wrote them all into two methods and all too very long lines of codes, but not anymore! We are going to change that. Now remember the `OperationRegion` `Offset` `0x18`, `FieldUnitObj` `Offset` `0x04`, and `FieldUnitObj` `Length` `256`.\
`BDAT` is read and written in `DSDT` total four times. Inside `Method (SMBR...` and `Method (SMBW...` under `Scope (\_SB.PCI0.LPCB.EC0)`.\
`SMBR`:
```
...
BDAT = Zero
...
Local0 [0x02] = BDAT
...
```
`SMBW`:
```
...
BDAT = Zero
...
BDAT = Arg4
...
```
In the above, the second statement is in the form of `Read` and all the others are `Write`. So let's make use of our new methods.\
`SMBR`:
```
...
WECB (0x18, 0x04, 256, Zero)
...
Local0 [0x02] = RECB (0x18, 0x04, 256)
...
```
`SMBW`:
```
...
WECB (0x18, 0x04, 256, Zero)
...
WECB (0x18, 0x04, 256, Arg4)
...
```
Now we are done!\
I have already uploaded the modified [SSDT-Battery.aml](SSDT-Battery.aml) so you can use it right away. In it, I have also renamed `B1B2` (now called `R16B`) and newly defined `W16B` method to write to a 16-bit `FieldUnitObj` instead to easily recognize that the `FieldUnitObj` and the corresponding `Method` has been patched.
## Other things
- What if the `OperationRegion` starts at `Offset` of `Zero`? Then `Arg0` should be `Zero`.
- Be careful when converting `Base10` and `Hex`. Example: `256 = 0x100`.
- If you have battery related `FieldUnitObjs` in `SystemMemory` `OperationRegions`, obviously you need to write new methods or at least modify the current ones. There is no need to do so for this ASUS laptop. But in case if you need it, see [SSDT-ECSMRW.dsl](Battery/SSDT-ECSMRW.dsl).
- Studying the ACPI specs and usages is more interesting than I thought. I might work on [Battery Information Supplement](https://github.com/acidanthera/VirtualSMC/blob/master/Docs/Battery%20Information%20Supplement.md) and [Hibernate on Low Battery](https://applelife.ru/threads/hibernate-pri-razrjade-batarei.2874421/). The latter one is the ultimate fix to this [issue](https://github.com/whatnameisit/Asus-Vivobook-X510UA-BQ490-Hackintosh/issues/9).
