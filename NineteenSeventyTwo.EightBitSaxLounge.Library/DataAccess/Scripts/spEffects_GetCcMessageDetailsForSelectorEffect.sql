CREATE PROCEDURE spEffects_GetCcMessageDetailsForSelectorEffect
    @MidiDeviceName VARCHAR(255),
    @EffectName VARCHAR(255),
    @EffectValue VARCHAR(255)
AS
BEGIN
    SELECT
        EF.CcChannel,
        EF.CcNumber,
        ES.SelectorCcValue
    FROM
        Effects EF
            JOIN
        dbo.EffectDetails ED1 ON EF.EffectsDetailsID = ED1.ID
            JOIN
        EffectSelections ES ON ES.ReverbEngineEffectID = EF.ID
            JOIN
        dbo.EffectDetails ED2 ON ES.EffectDetailsID = ED2.ID
    WHERE
        ED1.Name = @EffectName
      AND EF.MidiMusicDeviceID = (SELECT ID FROM MidiMusicDevices WHERE Name = @MidiDeviceName)
      AND ED2.Name = @EffectValue;
END
GO