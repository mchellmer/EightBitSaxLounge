CREATE PROCEDURE spMusicDevices_CreateMusicDevice
    @Name VARCHAR(255),
    @Description VARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;

    IF @Name IS NULL OR @Description IS NULL
        BEGIN
            RAISERROR ('Name and Description cannot be NULL', 16, 1);
        END

    INSERT INTO MusicDevices (Name, Description)
    VALUES (@Name, @Description);
END
GO