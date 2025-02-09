CREATE PROCEDURE spMidiEffectModeSettingDetails_CreateMidiEffectModeSettingDetails
    @MidiDeviceName VARCHAR(255),
    @MidiEffectName VARCHAR(255),
    @MidiEffectModeName VARCHAR(255),
    @MidiEffectSettingsEffectName VARCHAR(255),
    @MidiEffectModeSettingName VARCHAR(255),
    @MidiEffectModeSettingDescription VARCHAR(max)
AS
BEGIN
    SET NOCOUNT ON;

    -- check for nulls
    IF @MidiDeviceName IS NULL OR @MidiEffectName IS NULL OR @MidiEffectSettingsEffectName IS NULL OR @MidiEffectModeName IS NULL
        BEGIN
            RAISERROR ('Must provide names of an existing device and one of its effects, one of its modes, and a setting effect linking them on the device.', 16, 1);
        END

    IF @MidiEffectSettingsEffectName IS NULL OR @MidiEffectModeName IS NULL
        BEGIN
            RAISERROR ('Must provide names of an existing settings effect and an effect mode that it controls.', 16, 1);
        END

    IF @MidiEffectModeSettingName IS NULL OR @MidiEffectModeSettingDescription IS NULL
        BEGIN
            RAISERROR ('Must provide a name and description for the effect mode setting.', 16, 1);
        END

    -- get the effect by name for device
    DECLARE @MidiDeviceEffectID INT;
    SELECT @MidiDeviceEffectID = ME.ID FROM MidiEffects ME
    join EffectDetails ED on ME.EffectsDetailsID = ED.ID
    join MusicDevices MD on ME.MusicDeviceID = MD.ID
    WHERE ED.Name = @MidiEffectName
    AND MD.Name = @MidiDeviceName;
    IF @MidiDeviceEffectID IS NULL
        BEGIN
            RAISERROR ('Midi device effect not found by name provided.', 16, 1);
        END
        
    -- get the effect setting effect by name for the device
    DECLARE @MidiEffectSettingID INT;
    SELECT @MidiEffectSettingID = MES.ID FROM dbo.MidiEffectSettings MES
    join MidiEffects ME on MES.MidiEffectSettingEffectID = ME.ID
    join EffectDetails ED on ME.EffectsDetailsID = ED.ID
    WHERE MES.MidiEffectID = @MidiDeviceEffectID
    AND ED.Name = @MidiEffectSettingsEffectName
    IF @MidiEffectSettingID IS NULL
        BEGIN
            RAISERROR ('Midi device settings effect not found by name provided.', 16, 1);
        END
    
    -- get the effect mode by name for the device effect
    DECLARE @MidiEffectModeID INT;
    SELECT @MidiEffectModeID = MEM.ID FROM MidiEffectModes MEM
    join EffectDetails ED on MEM.EffectDetailsID = ED.ID
    join MidiEffects ME on MEM.MidiEffectID = ME.ID
    WHERE ED.Name = @MidiEffectModeName
    AND ME.ID = @MidiDeviceEffectID;
    IF @MidiEffectModeID IS NULL
        BEGIN
            RAISERROR ('Midi effect mode not found by name provided.', 16, 1);
        END
    
    -- get the effect detail by name or create it
    DECLARE @NewEffectModeDetailID INT;
    EXEC spEffectDetails_GetEffectDetail @MidiEffectModeSettingName, @NewEffectModeDetailID OUTPUT;
    IF @NewEffectModeDetailID IS NULL
        EXEC spEffectDetails_CreateEffectDetail @MidiEffectModeSettingName, @MidiEffectModeSettingDescription, @NewEffectModeDetailID OUTPUT;
        
    INSERT INTO MidiEffectModeSettingDetails (MidiEffectSettingID, MidiEffectModeID, EffectDetailsID)
    VALUES (@MidiEffectSettingID, @MidiEffectModeID, @NewEffectModeDetailID);
        
END
GO