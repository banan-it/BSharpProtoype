﻿CREATE PROCEDURE [dbo].[dal_Views__Save]
	@Views [dbo].[ViewList] READONLY, 
	@Permissions [dbo].[PermissionList] READONLY
AS
BEGIN
	DECLARE @PermissionsIndexedIds [dbo].[IndexedIdList];
	DECLARE @TenantId int = CONVERT(INT, SESSION_CONTEXT(N'TenantId'));
	DECLARE @Now DATETIMEOFFSET(7) = SYSDATETIMEOFFSET();
	DECLARE @UserId NVARCHAR(450) = CONVERT(NVARCHAR(450), SESSION_CONTEXT(N'UserId'));

	DELETE FROM [dbo].[Permissions]
	WHERE [Id] IN (SELECT [Id] FROM @Permissions WHERE [EntityState] = N'Deleted');

	MERGE INTO [dbo].[Views] AS t
	USING (
		SELECT 
			[Id]
		FROM @Views 
		WHERE [EntityState] IN (N'Inserted', N'Updated')
	) AS s ON (t.Id = s.Id)
	--WHEN MATCHED 
	--THEN
	--	UPDATE SET
	--		t.[ModifiedAt]	= @Now,
	--		t.[ModifiedBy]	= @UserId
	WHEN NOT MATCHED THEN
		INSERT (
			[TenantId], [Id], [CreatedAt], [CreatedBy], [ModifiedAt], [ModifiedBy]
		)
		VALUES (
			@TenantId, s.[Id], @Now,		@UserId,		@Now,		@UserId
		);

	INSERT INTO @PermissionsIndexedIds([Index], [Id])
	SELECT x.[Index], x.[Id]
	FROM
	(
		MERGE INTO [dbo].[Permissions] AS t
		USING (
			SELECT [Index], [Id], [ViewId], [Level], [Criteria], [Memo]
			FROM @Permissions
			WHERE [EntityState] IN (N'Inserted', N'Updated')
		) AS s ON t.Id = s.Id
		WHEN MATCHED THEN
			UPDATE SET 
				t.[ViewId]		= s.[ViewId], 
				t.[Level]		= s.[Level],
				t.[Criteria]	= s.[Criteria],
				t.[Memo]		= s.[Memo],
				t.[ModifiedAt]	= @Now,
				t.[ModifiedBy]	= @UserId
		WHEN NOT MATCHED THEN
			INSERT ([TenantId], [ViewId], [Level],	[Criteria], [Memo], [CreatedAt], [CreatedBy], [ModifiedAt], [ModifiedBy])
			VALUES (@TenantId, s.[ViewId], s.[Level], s.[Criteria], s.[Memo], @Now,		@UserId,		@Now,		@UserId)
		OUTPUT s.[Index], inserted.[Id]
	) As x
END;