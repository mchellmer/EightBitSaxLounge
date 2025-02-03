using System.Runtime.InteropServices;

namespace NineteenSeventyTwo.EightBitSaxLounge.Library.Models.Winmm;

/// <summary>
/// A class representing a MIDI output device.
/// </summary>
public class MidiOutDevice : MidiDevice
{
    /// <summary>
    /// A handle to reference the device port in communications.
    /// </summary>
    internal IntPtr Handle;
    
    /// <summary>
    /// The identifier of the MIDI output device.
    /// </summary>
    internal UInt32 DeviceId;
    
    /// <summary>
    /// The name of the MIDI output device.
    /// </summary>
    public string? DeviceName { get; set; }
    
    /// <summary>
    /// A flag indicating whether the MIDI output device is open
    /// </summary>
    public bool IsOpen;
    

    /// <summary>
    /// Closes the specified MIDI output device.
    /// </summary>
    /// <param name="handle">A handle to the MIDI output device to be closed.</param>
    /// <returns>
    /// An MmResult value indicating the result of the operation.
    /// </returns>
    /// <remarks>
    /// This method is defined in the external library winmm.dll.
    /// </remarks>
    [DllImport("winmm.dll")]
    internal static extern MmResult midiOutClose(IntPtr handle);
    
    /// <summary>
    /// Opens the specified MIDI output device.
    /// </summary>
    /// <param name="handle">A reference to the handle that will be used to communicate with the MIDI output device.</param>
    /// <param name="devId">The identifier of the MIDI output device.</param>
    /// <param name="midiOutCallback">
    /// A callback function for MIDI output. Since a callback for MIDI 'OUT' will not be implemented,
    /// NULL should be passed in for the callback argument, which is done here with IntPtr.Zero.
    /// </param>
    /// <param name="instance">User instance data passed to the callback function. Not used in this case.</param>
    /// <param name="flags">Flags for opening the MIDI output device.</param>
    /// <returns>
    /// An MmResult value indicating the result of the operation.
    /// </returns>
    /// <remarks>
    /// This method is defined in the external library winmm.dll.
    /// </remarks>
    [DllImport("winmm.dll")]
    internal static extern MmResult midiOutOpen(
        ref IntPtr handle,
        UInt32 devId,
        IntPtr midiOutCallback,
        UInt32 instance,
        MidiCallbackFlags flags);
    
    /// <summary>
    /// Sends a short MIDI message to the specified MIDI output device.
    /// </summary>
    /// <param name="handle">A handle to the MIDI output device.</param>
    /// <param name="msg">
    /// The MIDI message to be sent. This is a 32-bit unsigned long in unmanaged C, which corresponds to .NET's System.UInt32.
    /// </param>
    /// <returns>
    /// An MmResult value indicating the result of the operation.
    /// </returns>
    /// <remarks>
    /// This method is defined in the external library winmm.dll.
    /// </remarks>
    /// <example>
    /// MMRESULT midiOutShortMsg( HMIDIOUT hmo,  DWORD      dwMsg);
    /// a 32-bit 'unsigned long' in unmanaged C which corresponds to .NET's System.UInt32
    /// </example>
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