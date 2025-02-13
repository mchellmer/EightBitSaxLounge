using NineteenSeventyTwo.EightBitSaxLounge.Library.Models;

namespace NineteenSeventyTwo.EightBitSaxLounge.Library.DataAccess;

public class EffectsLoopData : IEffectsLoopData
{
    private readonly IDataAccess _sql;

    public EffectsLoopData(IDataAccess sql)
    {
        _sql = sql;
    }
    
    public async Task<EffectsLoop?> CreateAsync(string effectsLoopName, string effectsLoopDescription)
    {
        var results = await _sql.LoadDataAsync<EffectsLoop, dynamic>(
            "spEffectsLoops_CreateEffectsLoop",
            new { Name = effectsLoopName, Description = effectsLoopDescription },
            "Default");

        return results.FirstOrDefault();
    }
}