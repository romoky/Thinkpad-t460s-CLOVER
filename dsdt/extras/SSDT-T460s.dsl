// SSDT-XHC-T460S.dsl
//

DefinitionBlock ("", "SSDT", 2, "hack", "T460", 0)
{
    External(\_SB.PCI0.XHC, DeviceObj)
    External(\_SB.PCI0, DeviceObj)
    External(\_SB.PCI0.LPC, DeviceObj)
    External(\_SB.PCI0.LPC.KBD, DeviceObj)

    // inject properties for XHCI
    Method(\_SB.PCI0.XHC._DSM, 4)
    {
        If (!Arg2) { Return (Buffer() { 0x03 } ) }
        Local0 = Package()
        {
            "AAPL,current-available", Buffer() { 0x34, 0x08, 0, 0 },
            "AAPL,current-extra", Buffer() { 0x98, 0x08, 0, 0, },
            "AAPL,current-extra-in-sleep", Buffer() { 0x40, 0x06, 0, 0, },
            "AAPL,max-port-current-in-sleep", Buffer() { 0x34, 0x08, 0, 0 },
        }
        Return(Local0)
    }
}
//EOF
