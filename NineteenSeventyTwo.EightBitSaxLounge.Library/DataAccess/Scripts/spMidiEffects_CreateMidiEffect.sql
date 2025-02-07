CREATE PROCEDURE spMidiEffects_CreateMidiEffect
    @MidiDeviceName VARCHAR(255),
    @MidiEffectName VARCHAR(255),
    @MidiEffectDescription VARCHAR(max),
    @MidiCcValueTypeName VARCHAR(255),
    @MidiCcChannel INT,
    @MidiCcNumber INT,
    @MidiCcValueMin INT,
    @MidiCcValueMax INT,
    @MidiCcValue INT = 0
AS
BEGIN
    SET NOCOUNT ON;

    IF @MidiEffectName IS NULL OR @MidiEffectDescription IS NULL OR @MidiCcValueTypeName IS NULL
        BEGIN
            RAISERROR ('Must provide name, description, and midi cc value type.', 16, 1);
        END
        
    IF @MidiCcChannel IS NULL OR @MidiCcNumber IS NULL OR @MidiCcValueMin IS NULL OR @MidiCcValueMax IS NULL
        BEGIN
            RAISERROR ('Must provide all midi cc value details.', 16, 1);
        END

    DECLARE @MusicDeviceID INT;
    SELECT @MusicDeviceID = ID FROM MusicDevices WHERE Name = @MidiDeviceName;
    IF @MusicDeviceID IS NULL
        BEGIN
            RAISERROR ('Music device not found.', 16, 1);
        END

    DECLARE @MidiCcValueTypeID INT;
    SELECT @MidiCcValueTypeID = ID FROM MidiCcValueTypes WHERE Name = @MidiCcValueTypeName;
    IF @MidiCcValueTypeID IS NULL
        BEGIN
            RAISERROR ('MIDI CC value type type not found.', 16, 1);
        END

    DECLARE @NewEffectDetailID INT;
    EXEC spEffectDetails_GetEffectDetail @MidiEffectName, @NewEffectDetailID OUTPUT;
    IF @NewEffectDetailID IS NULL
        EXEC spEffectDetails_CreateEffectDetail @MidiEffectName, @MidiEffectDescription, @NewEffectDetailID OUTPUT;
    
    INSERT INTO MidiEffects (MusicDeviceID, EffectsDetailsID, MidiCcValueTypeID, CcChannel, CcNumber, CcValueMin, CcValueMax, CcValue)
    VALUES (@MusicDeviceID, 
            @NewEffectDetailID, 
            @MidiCcValueTypeID, 
            @MidiCcChannel, 
            @MidiCcNumber, 
            @MidiCcValueMin, 
            @MidiCcValueMax, 
            @MidiCcValue);
        
END
GO