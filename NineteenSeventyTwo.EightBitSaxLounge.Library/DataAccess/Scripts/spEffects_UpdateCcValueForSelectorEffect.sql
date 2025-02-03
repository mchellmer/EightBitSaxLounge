CREATE PROCEDURE spEffects_UpdateCcValueForSelectorEffect
    @MidiDeviceName VARCHAR(255),
    @EffectName VARCHAR(255),
    @EffectValue VARCHAR(255)
AS
BEGIN
    DECLARE @SelectorCcValue INT;

    -- Find the corresponding SelectorCcValue
    SELECT
        @SelectorCcValue = ES.SelectorCcValue
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
      AND EF.MidiMusicDeviceId = (SELECT ID FROM MidiMusicDevices WHERE Name = @MidiDeviceName)
      AND ED2.Name = @EffectValue;

    -- Update the CcValue in the Effects table
    UPDATE Effects
    SET CcValue = @SelectorCcValue
    WHERE
        EffectsDetailsID = (SELECT ID FROM EffectDetails WHERE Name = @EffectName)
      AND MidiMusicDeviceId = (SELECT ID FROM MidiMusicDevices WHERE Name = @MidiDeviceName);
END
GO