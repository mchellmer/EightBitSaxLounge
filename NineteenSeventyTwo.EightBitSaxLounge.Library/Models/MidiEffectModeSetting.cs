namespace NineteenSeventyTwo.EightBitSaxLounge.Library.Models;

/// <summary>
/// Associated <see cref="EffectDetails"/> with a <see cref="MidiEffectMode"/>'s <see cref="MidiEffectSetting"/>.
/// Handles that a <see cref="MidiEffect"/> may have some setting that has a unique effect depending on the mode.
/// </summary>
public class MidiEffectModeSetting
{
    /// <summary>
    /// The unique identifier for the <see cref="MidiEffectModeSetting"/>.
    /// </summary>
    public int Id { get; set; }
    
    /// <summary>
    /// The unique identifier for the <see cref="MidiEffectMode"/> being described by this association.
    /// </summary>
    public int MidiEffectModeId { get; set; }

    /// <summary>
    /// The unique identifier for the <see cref="MidiEffectSetting"/> that applies to the <see cref="MidiEffectMode"/>.
    /// </summary>
    public int MidiEffectSettingsId { get; set; }
    
    /// <summary>
    /// The unique identifier for the <see cref="EffectDetails"/> describing the <see cref="MidiEffectModeSetting"/>.
    /// </summary>
    public int EffectDetailsId { get; set; }
}