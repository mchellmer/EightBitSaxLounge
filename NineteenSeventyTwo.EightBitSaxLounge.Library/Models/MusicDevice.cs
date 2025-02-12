namespace NineteenSeventyTwo.EightBitSaxLounge.Library.Models;

/// <summary>
/// Represents a music device which can add <see cref="MidiEffect"/>s to the audio signal chain.
/// </summary>
public class MusicDevice
{
    public string Name { get; set; }
    public string Description { get; set; }
}