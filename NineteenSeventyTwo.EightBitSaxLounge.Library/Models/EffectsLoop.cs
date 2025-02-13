using Microsoft.Extensions.Primitives;

namespace NineteenSeventyTwo.EightBitSaxLounge.Library.Models;

/// <summary>
/// Represents an effects loop which is configured with a chain of <see cref="MusicDevice"/>s.
/// Handles storing details about different types of effects loops.
/// </summary>
public class EffectsLoop
{
    /// <summary>
    /// The unique identifier for the effects loop.
    /// </summary>
    public int Id { get; set; }
    
    /// <summary>
    /// The name of the effects loop.
    /// </summary>
    public required string Name { get; set; }
    
    /// <summary>
    /// The description of the effects loop.
    /// </summary>
    public required string Description { get; set; }
}