using NineteenSeventyTwo.EightBitSaxLounge.Library.Models;

namespace NineteenSeventyTwo.EightBitSaxLounge.Library.DataAccess;

public interface IEffectsLoopData
{
    Task<EffectsLoop?> CreateAsync(string effectsLoopName, string effectsLoopDescription);
}