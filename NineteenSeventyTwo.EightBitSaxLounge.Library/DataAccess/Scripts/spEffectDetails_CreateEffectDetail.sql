CREATE PROCEDURE spEffectDetails_CreateEffectDetail
    @Name VARCHAR(255),
    @Description VARCHAR(MAX),
    @EffectDetailID INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    IF @Name IS NULL OR @Description IS NULL
        BEGIN
            RAISERROR ('Name and Description cannot be NULL', 16, 1);
        END

    INSERT INTO EffectDetails (Name, Description)
    VALUES (@Name, @Description);
    
    SELECT @EffectDetailID = SCOPE_IDENTITY();
END
GO