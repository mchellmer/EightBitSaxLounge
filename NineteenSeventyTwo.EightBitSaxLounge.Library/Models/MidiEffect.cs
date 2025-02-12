namespace NineteenSeventyTwo.EightBitSaxLounge.Library.Models;

public class MidiEffect
{
    public int MidiMusicDeviceId { get; set; }
    public int EffectsDetailsId { get; set; }
    public int CcChannel { get; set; }
    public int CcNumber { get; set; }
    public int CcValueMin { get; set; }
    public int CcValueMax { get; set; }
    public int CcValue {get; set; }
}