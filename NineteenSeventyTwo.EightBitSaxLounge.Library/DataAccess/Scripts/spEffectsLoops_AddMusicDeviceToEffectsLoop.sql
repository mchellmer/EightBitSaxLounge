CREATE PROCEDURE spEffectsLoops_AddMusicDeviceToEffectsLoop
    @EffectsLoopName VARCHAR(255),
    @MusicDeviceName VARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;

    IF @EffectsLoopName IS NULL OR @MusicDeviceName IS NULL
        BEGIN
            RAISERROR ('Must provide names of both effects loop and music device.', 16, 1);
        END

    INSERT INTO EffectsLoopDevices (EffectsLoopID, MusicDeviceID)
    VALUES ((SELECT ID FROM EffectsLoops WHERE Name = @EffectsLoopName),
           (SELECT ID FROM MusicDevices WHERE Name = @MusicDeviceName));
        
END
GO