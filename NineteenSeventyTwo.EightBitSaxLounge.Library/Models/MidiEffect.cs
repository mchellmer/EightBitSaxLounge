namespace NineteenSeventyTwo.EightBitSaxLounge.Library.Models;

/// <summary>
/// Represents a MIDI effect available via a <see cref="MusicDevice"/>.
/// Handles associating details, settings, and setting MIDI config for the effect.
/// </summary>
public class MidiEffect
{
    /// <summary>
    /// The unique identifier for the MIDI effect.
    /// </summary>
    public int Id { get; set; }
    
    /// <summary>
    /// The unique identifier for the <see cref="MusicDevice"/> on which the MIDI effect is available.
    /// </summary>
    public int MidiMusicDeviceId { get; set; }
    
    /// <summary>
    /// The unique identifier for the <see cref="EffectDetails"/> provides information about the <see cref="MidiEffect"/>.
    /// </summary>
    public int EffectDetailsId { get; set; }
    
    /// <summary>
    /// The MIDI CC channel for the <see cref="MidiEffect"/>.
    /// </summary>
    public int CcChannel { get; set; }
    
    /// <summary>
    /// The MIDI CC number for the <see cref="MidiEffect"/>.
    /// </summary>
    public int CcNumber { get; set; }
    
    /// <summary>
    /// The minimum int MIDI CC value for the <see cref="MidiEffect"/>.
    /// </summary>
    public int CcValueMin { get; set; }
    
    /// <summary>
    /// The max int MIDI CC value for the <see cref="MidiEffect"/>.
    /// </summary>
    public int CcValueMax { get; set; }
    
    /// <summary>
    /// The current MIDI CC value set for the <see cref="MidiEffect"/>.
    /// </summary>
    public int CcValue {get; set; }
}