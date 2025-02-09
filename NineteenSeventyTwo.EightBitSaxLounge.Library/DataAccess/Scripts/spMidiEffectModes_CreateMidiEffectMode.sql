CREATE PROCEDURE spMidiEffectModes_CreateMidiEffectMode
    @MusicDeviceName VARCHAR(255),
    @MidiEffectName VARCHAR(255),
    @MidiEffectModeName VARCHAR(255),
    @MidiEffectModeDescription VARCHAR(max),
    @MidiCcValue INT
AS
BEGIN
    SET NOCOUNT ON;

    IF @MusicDeviceName IS NULL OR @MidiEffectName IS NULL OR @MidiEffectModeDescription IS NULL OR @MidiEffectModeName IS NULL
        BEGIN
            RAISERROR ('Must device and effect names, as well as a mode name and description to add.', 16, 1);
        END
        
    IF @MidiCcValue IS NULL
        BEGIN
            RAISERROR ('Must provide cc value that sets the midi device effect mode to the one being created.', 16, 1);
        END

    DECLARE @MidiDeviceEffectID INT;
    SELECT @MidiDeviceEffectID = ME.ID FROM MidiEffects ME
    join EffectDetails ED on ME.EffectsDetailsID = ED.ID
    join MusicDevices MD on ME.MusicDeviceID = MD.ID
    WHERE MD.Name = @MusicDeviceName
    AND ED.Name = @MidiEffectName;
    IF @MidiDeviceEffectID IS NULL
        BEGIN
            RAISERROR ('Midi effect not found by name provided.', 16, 1);
        END

    DECLARE @NewEffectModeDetailID INT;
    EXEC spEffectDetails_GetEffectDetail @MidiEffectModeName, @NewEffectModeDetailID OUTPUT;
    IF @NewEffectModeDetailID IS NULL
        EXEC spEffectDetails_CreateEffectDetail @MidiEffectModeName, @MidiEffectModeDescription, @NewEffectModeDetailID OUTPUT;
    
    INSERT INTO MidiEffectModes (MidiEffectID, EffectDetailsID, SelectorCcValue)
    VALUES (@MidiDeviceEffectID, 
            @NewEffectModeDetailID, 
            @MidiCcValue);
        
END
GO