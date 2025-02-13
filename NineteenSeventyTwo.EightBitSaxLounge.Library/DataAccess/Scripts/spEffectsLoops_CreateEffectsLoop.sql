CREATE PROCEDURE spEffectsLoops_CreateEffectsLoop
    @Name VARCHAR(255),
    @Description VARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;

    IF @Name IS NULL OR @Description IS NULL
        BEGIN
            RAISERROR ('Name and Description cannot be NULL', 16, 1);
        END

    INSERT INTO EffectsLoops (Name, Description)
    VALUES (@Name, @Description);
    
    SELECT * FROM EffectsLoops WHERE Id = SCOPE_IDENTITY();
END
GO