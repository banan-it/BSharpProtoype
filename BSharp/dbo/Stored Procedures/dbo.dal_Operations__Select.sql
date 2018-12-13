﻿CREATE PROCEDURE [dbo].[dal_Operations__Select]
	@IndexedIds dbo.IndexedIdList READONLY,
	@OperationsResultJson NVARCHAR(MAX) OUTPUT
AS
SELECT @OperationsResultJson =	(
	SELECT
		T.[Index], O.[Id], O.[OperationType], O.[Name], O.[ParentId], O.[IsActive], O.[Code], 
		O.[CreatedAt], O.[CreatedBy], O.[ModifiedAt], O.[ModifiedBy], N'Unchanged' As [EntityState]
	FROM [dbo].Operations O JOIN (
		SELECT [Index], [Id] 
		FROM @IndexedIds
	) T ON O.Id = T.Id
	FOR JSON PATH
);