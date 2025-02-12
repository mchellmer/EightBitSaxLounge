using Microsoft.Extensions.Primitives;

namespace NineteenSeventyTwo.EightBitSaxLounge.Library.Models;

/// <summary>
/// Represents an effects loop which is configured with a chain of <see cref="MusicDevice"/>s.
/// </summary>
public class EffectsLoop
{
    public string Name { get; set; }
    public string Description { get; set; }
}