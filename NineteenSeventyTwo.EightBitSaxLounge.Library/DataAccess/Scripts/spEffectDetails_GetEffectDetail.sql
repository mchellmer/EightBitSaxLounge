CREATE PROCEDURE spEffectDetails_GetEffectDetail
    @Name VARCHAR(255),
    @NewEffectDetailID INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    IF @Name IS NULL
        BEGIN
            RAISERROR ('Name cannot be NULL', 16, 1);
        END

    SELECT @NewEffectDetailID = ID FROM EffectDetails WHERE Name = @Name;
END
GO