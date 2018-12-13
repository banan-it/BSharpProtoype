﻿CREATE PROCEDURE [dbo].[api_Resources__Save]
	@Resources [dbo].[ResourceForSaveList] READONLY,
	@ValidationErrorsJson NVARCHAR(MAX) OUTPUT,
	@ReturnEntities bit = 1,
	@ResourcesResultJson NVARCHAR(MAX) OUTPUT
AS
BEGIN
SET NOCOUNT ON;
DECLARE @IndexedIdsJson NVARCHAR(MAX), @IndexedIds dbo.[IndexedIdList];
-- Validate
	EXEC [dbo].[bll_Resources__Validate]
		@Resources = @Resources,
		@ValidationErrorsJson = @ValidationErrorsJson OUTPUT;

	IF @ValidationErrorsJson IS NOT NULL
		RETURN;

	EXEC [dbo].[dal_Resources__Save]
		@Resources = @Resources,
		@IndexedIdsJson = @IndexedIdsJson OUTPUT;

	IF (@ReturnEntities = 1)
	BEGIN
		INSERT INTO @IndexedIds([Index], [Id])
		SELECT [Index], [Id] 
		FROM OpenJson(@IndexedIdsJson)
		WITH ([Index] INT '$.Index', [Id] INT '$.Id');

		EXEC [dbo].[dal_Resources__Select] 
			@IndexedIds = @IndexedIds, @ResourcesResultJson = @ResourcesResultJson OUTPUT;
	END
END