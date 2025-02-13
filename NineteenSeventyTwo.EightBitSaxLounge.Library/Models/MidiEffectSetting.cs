namespace NineteenSeventyTwo.EightBitSaxLounge.Library.Models;

/// <summary>
/// Represents a setting for a <see cref="MidiEffect"/>.
/// Handles that a <see cref="MidiEffect"/> may have multiple settings that are themselves <see cref="MidiEffect"/>s layered on top of each other.
/// </summary>
public class MidiEffectSetting
{
    /// <summary>
    /// The unique identifier for the <see cref="MidiEffectSetting"/>.
    /// </summary>
    public int Id { get; set; }
    
    /// <summary>
    /// The unique identifier for the <see cref="MidiEffect"/> to which the <see cref="MidiEffectSetting"/> belongs.
    /// </summary>
    public int MidiEffectId { get; set; }
    
    /// <summary>
    /// The unique identifier for the <see cref="MidiEffect"/> that describes and sets MIDI configuration for this settings effect.
    /// </summary>
    public int MidiEffectSettingsEffectId { get; set; }
}