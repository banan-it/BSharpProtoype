﻿CREATE PROCEDURE [dbo].[bll_Transactions_Validate__Post]
	@Transactions [dbo].[IndexedIdList] READONLY,
	@ValidationErrorsJson NVARCHAR(MAX) OUTPUT
AS
SET NOCOUNT ON;
	DECLARE @ValidationErrors [dbo].[ValidationErrorList];
	DECLARE @Now DATETIMEOFFSET(7) = SYSDATETIMEOFFSET();

	-- Cannot post unless in draft mode
	INSERT INTO @ValidationErrors([Key], [ErrorName], [Argument1], [Argument2], [Argument3], [Argument4], [Argument5]) 
	SELECT
		'[' + CAST(FE.[Index] AS NVARCHAR (255)) + '].[DocumentState]' As [Key], N'Error_TheTransaction0IsIn1State' As [ErrorName],
		BE.[SerialNumber] AS Argument1, BE.[DocumentState] AS Argument2, NULL AS Argument3, NULL AS Argument4, NULL AS Argument5
	FROM @Transactions FE
	JOIN [dbo].[Documents] BE ON FE.[Id] = BE.[Id]
	WHERE (BE.[DocumentState] <> N'Draft');

	-- Cannot post with no lines
	INSERT INTO @ValidationErrors([Key], [ErrorName], [Argument1], [Argument2], [Argument3], [Argument4], [Argument5]) 
	SELECT '[' + CAST(FE.[Index] AS NVARCHAR (255)) + ']' As [Key], N'Error_TheTransaction0HasNoEntries' As [ErrorName],
		D.[SerialNumber] AS Argument1, NULL AS Argument2, NULL AS Argument3, NULL AS Argument4, NULL AS Argument5
	FROM @Transactions FE 
	JOIN dbo.Documents D ON FE.[Id] = D.[Id]
	LEFT JOIN dbo.[TransactionEntries] E ON D.[Id] = E.[DocumentId]
	WHERE (E.DocumentId IS NULL);

	-- Cannot post a non-balanced transaction
	INSERT INTO @ValidationErrors([Key], [ErrorName], [Argument1], [Argument2], [Argument3], [Argument4], [Argument5]) 
	SELECT
		'[' + ISNULL(CAST(FE.[Index] AS NVARCHAR (255)),'') + ']' As [Key], 
		N'Error_Transaction0HasDebitCreditDifference1' As [ErrorName],
		D.[SerialNumber] AS Argument1, SUM(E.[Direction] * E.[Value]) AS Argument2, NULL AS Argument3, NULL AS Argument4, NULL AS Argument5
	FROM @Transactions FE
	JOIN dbo.Documents D ON FE.[Id] = D.[Id]
	JOIN dbo.[TransactionEntries] E ON D.[Id] = E.[DocumentId]
	GROUP BY FE.[Index], D.[SerialNumber]
	HAVING SUM(E.[Direction] * E.[Value]) <> 0;

	-- No inactive account
	INSERT INTO @ValidationErrors([Key], [ErrorName], [Argument1], [Argument2], [Argument3], [Argument4], [Argument5]) 
	SELECT
		'[' + CAST(FE.[Index] AS NVARCHAR (255)) + '].Entries[' +
		CAST(E.[Id] AS NVARCHAR (255)) + '].AccountId' As [Key], N'Error_TheTransaction0TheAccountId1IsInactive' As [ErrorName],
		E.SerialNumber AS Argument1, E.[AccountId] AS Argument2, NULL AS Argument3, NULL AS Argument4, NULL AS Argument5
	FROM @Transactions FE
	JOIN dbo.[TransactionEntriesView] E ON FE.[Id] = E.[DocumentId]
	JOIN dbo.[IfrsConcepts] IC ON E.IfrsAccountId = IC.Id
	WHERE (IC.IsActive = 0);

	-- No inactive Responsibility Center, AgentAccount, Resource, Related resource, Related Agent Account, Related Responsibility Center
	-- No 

	SELECT @ValidationErrorsJson = (SELECT * FROM @ValidationErrors	FOR JSON PATH);