namespace NineteenSeventyTwo.EightBitSaxLounge.Library.Models;

/// <summary>
/// Represents a MIDI effect mode for a <see cref="MidiEffect"/>.
/// Handles that a <see cref="MidiEffect"/> may have multiple modes, associating th effect and details, and setting MIDI config.
/// </summary>
public class MidiEffectMode
{
    /// <summary>
    /// The unique identifier for the MIDI effect mode.
    /// </summary>
    public int Id { get; set; }
    
    /// <summary>
    /// The unique identifier for the <see cref="MidiEffect"/> to which the MIDI effect mode belongs.
    /// </summary>
    public int MidiEffectId { get; set; }

    /// <summary>
    /// The unique identifier for the <see cref="EffectDetails"/> that provides information about the MIDI effect mode.
    /// </summary>
    public int EffectDetailsId { get; set; }
    
    /// <summary>
    /// The CC Value that sets the <see cref="MidiEffect"/> to this mode.
    /// </summary>
    public int SelectorCcValue { get; set; }
}