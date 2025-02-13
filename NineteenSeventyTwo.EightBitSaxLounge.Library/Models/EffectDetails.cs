using System.ComponentModel.DataAnnotations;

namespace NineteenSeventyTwo.EightBitSaxLounge.Library.Models;

/// <summary>
/// Represents the details describing a <see cref="MidiEffect"/>, <see cref="MidiEffectMode"/>, or <see cref="MidiEffectModeSetting"/>.
/// Handles that several <see cref="MusicDevice"/> options have the same names and descriptions.
/// </summary>
public class EffectDetails
{
    /// <summary>
    /// The unique identifier for the <see cref="EffectDetails"/>.
    /// </summary>
    public int Id { get; set; }
    
    /// <summary>
    /// The name of the <see cref="MidiEffect"/>, <see cref="MidiEffectMode"/>, or <see cref="MidiEffectModeSetting"/>.
    /// </summary>
    public required string Name { get; set; }
    
    /// <summary>
    /// The description of the <see cref="MidiEffect"/>, <see cref="MidiEffectMode"/>, or <see cref="MidiEffectModeSetting"/>.
    /// </summary>
    [Required]
    public required string Description { get; set; }
}