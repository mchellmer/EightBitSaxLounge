using System.Collections;
using System.Runtime.InteropServices;
using NineteenSeventyTwo.EightBitSaxLounge.Library.Models.Winmm;

namespace NineteenSeventyTwo.EightBitSaxLounge.Library.MidiControl;

public class WinmmMidiPort
{
    /// <summary>
    /// Get MIDI devices available output devices available on the system.
    /// </summary>
    /// <returns>
    /// An ArrayList of MIDI output devices.
    /// </returns>
    public static List<MidiOutDevice> GetMidiOutputDevices()
    {
        var midiOutDevices = new List<MidiOutDevice>();

        UInt32 numDevs = midiOutGetNumDevs();
        if (numDevs > 0)
        {
            MidiOutCaps outCaps = new MidiOutCaps();
            for (UInt32 dev = 0; dev < numDevs; ++dev)
            {
                MmResult res = midiOutGetDevCapsA(dev, ref outCaps, (UInt32)Marshal.SizeOf(outCaps));
                if (res == MmResult.NoError)
                {
                    MidiOutDevice outDev = new MidiOutDevice
                    {
                        DeviceId = dev,
                        DeviceName = outCaps.deviceName,
                    };
                    midiOutDevices.Add(outDev);
                }
            }
        }
        
        return midiOutDevices;
    }
    
    /// <summary>
    /// Retrieves the capabilities of a specified MIDI output device.
    /// </summary>
    /// <param name="devId">The identifier of the MIDI output device.</param>
    /// <param name="devCaps">A reference to a MidiOutCaps structure to be filled with the device capabilities.</param>
    /// <param name="devCapsSize">The size, in bytes, of the MidiOutCaps structure.</param>
    /// <returns>
    /// An MmResult value indicating the result of the operation.
    /// </returns>
    /// <remarks>
    /// This method is defined in the external library winmm.dll.
    /// </remarks>
    [DllImport("winmm.dll", EntryPoint = "midiOutGetDevCaps")]
    private static extern MmResult midiOutGetDevCapsA(UInt32 devId, ref MidiOutCaps devCaps, UInt32 devCapsSize);
    
    /// <summary>
    /// Get number of MIDI output devices on the system.
    /// </summary>
    /// <returns>
    /// The number of MIDI output devices.
    /// </returns>
    /// <remarks>
    /// Using method defined in external library winmm.dll.
    /// </remarks>
    [DllImport("winmm.dll")]
    private static extern UInt32 midiOutGetNumDevs();
}