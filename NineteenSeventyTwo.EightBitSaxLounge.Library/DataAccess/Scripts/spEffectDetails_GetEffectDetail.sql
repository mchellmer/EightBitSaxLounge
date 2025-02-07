CREATE PROCEDURE spEffectDetails_GetEffectDetail
    @Name VARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;

    IF @Name IS NULL
        BEGIN
            RAISERROR ('Name cannot be NULL', 16, 1);
        END

    SELECT ID FROM EffectDetails WHERE Name = @Name;
END
GO