﻿CREATE PROCEDURE [dbo].[dal_Roles__Activate]
	@Ids [dbo].[IntegerList] READONLY,
	@IsActive bit
AS
	DECLARE @Now DATETIMEOFFSET(7) = SYSDATETIMEOFFSET();
	DECLARE @UserId NVARCHAR(450) = CONVERT(NVARCHAR(450), SESSION_CONTEXT(N'UserId'));

	MERGE INTO [dbo].Roles AS t
	USING (
		SELECT [Id]
		FROM @Ids
	) AS s ON (t.Id = s.Id)
	WHEN MATCHED AND (t.IsActive <> @IsActive)
	THEN
		UPDATE SET 
			t.[IsActive]	= @IsActive,
			t.[ModifiedAt]	= @Now,
			t.[ModifiedBy]	= @UserId;