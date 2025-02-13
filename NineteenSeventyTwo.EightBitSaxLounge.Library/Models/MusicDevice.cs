namespace NineteenSeventyTwo.EightBitSaxLounge.Library.Models;

/// <summary>
/// Represents a music device which can add <see cref="MidiEffect"/>s to the audio signal chain.
/// </summary>
public class MusicDevice
{
    /// <summary>
    /// The unique identifier for the music device.
    /// </summary>
    public required string Name { get; set; }
    
    /// <summary>
    /// The description of the music device.
    /// </summary>
    public required string Description { get; set; }
}