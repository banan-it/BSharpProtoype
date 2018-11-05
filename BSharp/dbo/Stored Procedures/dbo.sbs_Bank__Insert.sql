﻿
CREATE PROCEDURE [dbo].[sbs_Bank__Insert] 
--	DECLARE @BananIT int; EXEC [dbo].[sbs_Bank__Insert] @LongName = N'Banan Information technologies, plc', @ShortName = N'Banan IT', @BirthDateTime = '2017.08.09', @Email = N'info@banan-it.com', @BankType = N'plc', @NumberOfShares = 1000, @Bank = @BananIT OUTPUT
	@LongName nvarchar(255),
	@ShortName nvarchar(50),
	@BirthDateTime datetimeoffset(7) = NULL,
	@DeathDateTime datetimeoffset(7) = NULL,
	@TaxIdentificationNumber nvarchar(50) = NULL,
	@UserId nvarchar(450) = NULL,
	@RegisteredAddress nvarchar(255) = NULL,
	@Bank int OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRANSACTION

	BEGIN TRY

		DECLARE @Type nvarchar(50)
		SET @Type = N'Bank'

		INSERT INTO dbo.Custodies(CustodyType, [Name])
		VALUES(@Type, @ShortName);

		SET @Bank = SCOPE_IDENTITY();

		INSERT INTO dbo.Agents(Id, AgentType, LongName, ShortName, BirthDateTime, DeathDateTime, TaxIdentificationNumber, UserId, RegisteredAddress)
		VALUES(@Bank, @Type, @LongName, @ShortName, @BirthDateTime, @DeathDateTime, @TaxIdentificationNumber, @UserId, @RegisteredAddress)

		SET @Bank = SCOPE_IDENTITY();
	END TRY

	BEGIN CATCH
	    SELECT   /*
        ERROR_NUMBER() AS ErrorNumber  
        ,ERROR_SEVERITY() AS ErrorSeverity  
        ,ERROR_STATE() AS ErrorState  
        , */ERROR_PROCEDURE() AS ErrorProcedure  
        ,ERROR_LINE() AS ErrorLine  
        ,ERROR_MESSAGE() AS ErrorMessage; 

		IF @@TRANCOUNT > 0 
        ROLLBACK TRANSACTION;
	END CATCH

	IF @@TRANCOUNT > 0  
    COMMIT TRANSACTION; 
END

