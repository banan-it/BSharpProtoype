﻿
CREATE FUNCTION [dbo].[Custody](@EntryNumber tinyint, @Entries EntryList READONLY)
RETURNS int
AS
BEGIN
	DECLARE @Result int

	SELECT @Result = CustodyId
	FROM @Entries
	WHERE EntryNumber = @EntryNumber

	RETURN @Result

END
