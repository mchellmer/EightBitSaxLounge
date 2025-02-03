using System.Runtime.InteropServices;

namespace NineteenSeventyTwo.EightBitSaxLounge.Library.Models.Winmm;

internal class MidiOutDevice : MidiDevice
{
    internal IntPtr Handle;   // a handle to reference the device port in communications
    internal UInt32 DeviceId;
    public string? DeviceName;
    public bool IsOpen;
    
    [DllImport("winmm.dll")]
    internal static extern MmResult midiOutClose(IntPtr handle);
    
    // a callback for MIDI 'OUT' will not be implemented
    // in this case NULL should be passed in for the callback argument
    // here, this will be done with IntPtr.Zero
    [DllImport("winmm.dll")]
    internal static extern MmResult midiOutOpen(ref IntPtr handle, UInt32 devId, IntPtr midiOutCallback, UInt32 instance, MidiCallbackFlags flags);
    
    // MMRESULT midiOutShortMsg(
    //   HMIDIOUT hmo,
    //   DWORD    dwMsg);     this is a 32-bit 'unsigned long' in unmanaged C which corresponds to .NET's System.UInt32
    [DllImport("winmm.dll")]
    internal static extern MmResult midiOutShortMsg(IntPtr handle, UInt32 msg);
    
    public override void Open() 
    {
        MmResult result = MmResult.NoError;

        if (!IsOpen)
        {
            result = midiOutOpen(ref Handle, DeviceId, IntPtr.Zero, 0, MidiCallbackFlags.NoCallBack);

            if (result == MmResult.NoError)
                IsOpen = true;
        }
    }

    public override void Close() 
    {
        MmResult result = MmResult.NoError;

        if (IsOpen)
        {
            result = midiOutClose(Handle);

            if (result == MmResult.NoError)
                IsOpen = false;
        }
    }

    public void SendCcMsg(UInt32 msg)
    {
        if (IsOpen)
            midiOutShortMsg(Handle, msg);
    }
}