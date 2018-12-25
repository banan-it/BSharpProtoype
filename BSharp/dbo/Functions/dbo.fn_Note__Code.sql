﻿CREATE FUNCTION [dbo].[fn_Note__Code]
(
	@NoteId NVARCHAR(255)
)
RETURNS NVARCHAR(255)
AS
BEGIN
	RETURN (SELECT Code FROM dbo.Notes WHERE Id = @NoteId);
END;