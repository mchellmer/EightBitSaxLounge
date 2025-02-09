CREATE PROCEDURE spMidiEffectSettings_CreateMidiEffectSetting
    @MidiDeviceName VARCHAR(255),
    @MidiEffectName VARCHAR(255),
    @MidiEffectSettingsEffectName VARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;

    IF @MidiDeviceName IS NULL OR @MidiEffectName IS NULL OR @MidiEffectSettingsEffectName IS NULL
        BEGIN
            RAISERROR ('Must provide names of an existing device and one of its effects as well as another effect to associate as a settings effect.', 16, 1);
        END

    DECLARE @MidiEffectID INT;
    SELECT @MidiEffectID = ME.ID FROM MidiEffects ME
    join EffectDetails ED on ME.EffectsDetailsID = ED.ID
    join MusicDevices MD on ME.MusicDeviceID = MD.ID
    WHERE MD.Name = @MidiDeviceName
    AND ED.Name = @MidiEffectName;
    IF @MidiEffectID IS NULL
        BEGIN
            RAISERROR ('Midi device effect not found by name provided.', 16, 1);
        END

    DECLARE @MidiEffectSettingsEffectID INT;
    SELECT @MidiEffectSettingsEffectID = ME.ID FROM MidiEffects ME
    join EffectDetails ED on ME.EffectsDetailsID = ED.ID
    join MusicDevices MD on ME.MusicDeviceID = MD.ID
    WHERE MD.Name = @MidiDeviceName
    AND ED.Name = @MidiEffectSettingsEffectName;
    IF @MidiEffectSettingsEffectID IS NULL
        BEGIN
            RAISERROR ('Midi device settings effect not found by name provided.', 16, 1);
        END
    
    INSERT INTO MidiEffectSettings (MidiEffectID, MidiEffectSettingEffectID)
    VALUES (@MidiEffectID, 
            @MidiEffectSettingsEffectID);
        
END
GO