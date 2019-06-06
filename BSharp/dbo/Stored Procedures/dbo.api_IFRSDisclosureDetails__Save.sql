﻿CREATE PROCEDURE [dbo].[api_IfrsDisclosureDetails__Save]
	@Entities [IfrsDisclosureDetailList] READONLY,
	@ValidationErrorsJson NVARCHAR(MAX) OUTPUT,
	@ReturnEntities bit = 1,
	@ResultsJson NVARCHAR(MAX) OUTPUT
AS
BEGIN
SET NOCOUNT ON;
DECLARE @IndexedIdsJson NVARCHAR(MAX), @Ids [dbo].[IdList];
-- Validate
	EXEC [dbo].[bll_IfrsDisclosureDetails_Validate__Save]
		@Entities = @Entities,
		@ValidationErrorsJson = @ValidationErrorsJson OUTPUT;

	IF @ValidationErrorsJson IS NOT NULL
		RETURN;
	
	EXEC [dbo].[dal_IfrsDisclosureDetails__Save]
		@Entities = @Entities,
		@IndexedIdsJson = @IndexedIdsJson OUTPUT;

	IF (@ReturnEntities = 1)
	BEGIN
		INSERT INTO @Ids([Id])
		SELECT [Id] 
		FROM OpenJson(@IndexedIdsJson) WITH ([Index] INT, [Id] INT);
		
		EXEC [dbo].[dal_IfrsDisclosureDetails__Select] 
			@Ids = @Ids, @ResultsJson = @ResultsJson OUTPUT;
	END
END;