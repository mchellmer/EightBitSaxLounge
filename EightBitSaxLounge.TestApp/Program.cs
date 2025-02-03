// See https://aka.ms/new-console-template for more information

using NineteenSeventyTwo.EightBitSaxLounge.Library.MidiControl;
using NineteenSeventyTwo.EightBitSaxLounge.Library.Models.Winmm;

// Get the MIDI output devices
var midiOutDevices = WinmmMidiPort.GetMidiOutputDevices();
foreach (var dev in midiOutDevices)
{
    Console.WriteLine(dev.DeviceName);
}