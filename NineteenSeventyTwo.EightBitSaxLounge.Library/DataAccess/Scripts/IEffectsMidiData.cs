using NineteenSeventyTwo.EightBitSaxLounge.Library.Models;

namespace NineteenSeventyTwo.EightBitSaxLounge.Library.DataAccess.Scripts;

/// <summary>
/// The IEffectsMidiData interface is used to interact with MIDI effects data.
/// </summary>
public interface IEffectsMidiData
{
    Task<EffectsLoop> CreateEffectsLoopAsync(EffectsLoop effectsLoop);
    
    /// <summary>
    /// Get <see cref="Effect"/> by name.
    /// </summary>
    Task<Effect> GetEffectByNameAsync(string effectName);
    
    /// <summary>
    /// Update the midi control change value for an <see cref="Effect"/> where the value is named.
    /// </summary>
    /// <param name="effectName">The name of the <see cref="Effect"/>.</param>
    /// <param name="effectValueName">The new midi control change value for the <see cref="Effect"/>.</param>
    /// <example>
    /// UpdateEffectCcValueByEffectNameAsync("EngineA", "Room"); - sets EngineA CC value to 'Room' selection value.
    /// </example>
    Task UpdateEffectCcValueByEffectAndValueNameAsync(string effectName, string effectValueName);
    
    /// <summary>
    /// Update the midi control change value for an <see cref="Effect"/> where the value is incremental.
    /// </summary>
    /// <param name="effectName">The name of the <see cref="Effect"/>.</param>
    /// <param name="ccValue">The new midi control change value for the <see cref="Effect"/>.</param>
    /// <example>
    /// UpdateEffectCcValueByEffectNameAndCcValueAsync("Bass", 64); - sets CC value to 64 for the Bass effect.
    /// </example>
    Task UpdateEffectCcValueByEffectNameAndCcValueAsync(string effectName, int ccValue);
}