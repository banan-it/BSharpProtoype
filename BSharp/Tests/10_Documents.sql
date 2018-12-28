﻿BEGIN -- Cleanup & Declarations
	DECLARE @DSave [dbo].DocumentForSaveList;
	DECLARE @LSave [dbo].LineForSaveList, @WLSave [dbo].WideLineForSaveList;
	DECLARE @ESave [dbo].EntryForSaveList;

	DECLARE @DResultJson NVARCHAR(MAX), @LResultJson NVARCHAR(MAX), @EResultJson NVARCHAR(MAX), @WLResultJson NVARCHAR(MAX);;

	DECLARE @Docs [dbo].[IndexedIdForSaveList], @DIdx INT, @LIdx INT;
END
-- get acceptable document types; and user permissions and general settings;
-- Journal Vouchers
DECLARE @VR1_2 VTYPE, @VRU_3 VTYPE, @Frequency NVARCHAR(255), @P1_2 int, @P1_U int, @PU_3 int, @P2_3 int,
		@d1 datetime = '2017.02.01', @d2 datetime = '2022.02.01', @dU datetime = '2018.02.01', @d3 datetime = '2023.02.01';
		--:r .\11M_Financing.sql
		:r .\11W_Financing.sql
		--:r .\12_PurchasingCycle.sql
		--:r .\13_ProductionCycle.sql
		--:r .\14_SalesCycle.sql
--		:r .\12_ManualMisc.sql
--SELECT @fromDate = '2017.01.01', @toDate = '2017.01.02'
--SELECT * from ft_Journal(@fromDate, @toDate) ORDER BY [Id], [LineId], [EntryId];
--EXEC rpt_TrialBalance @fromDate = @fromDate, @toDate = @toDate, @ByCustody = 1, @ByResource = 1, @PrintQuery = 0;


/*
INSERT INTO @D2Save(
	[Id], [State], [DocumentType],	[Memo],[StartDateTime], [EndDateTime],
	[LinesCustody1], [LinesCustody2], [LinesCustody3], [LinesReference1], [LinesReference2], [LinesReference3],
	[EntityState]
)
SELECT 
	[Id], [State], [DocumentType], [Memo],[StartDateTime], [EndDateTime],
	[LinesCustody1], [LinesCustody2], [LinesCustody3], [LinesReference1], [LinesReference2], [LinesReference3],
	N'Unchanged' As [EntityState]
FROM [dbo].[Documents] WHERE Memo Like N'Capital%'
INSERT INTO @L2Save(
	[Id], [DocumentIndex], [DocumentId], [BaseLineId], [ScalingFactor], [Memo], [EntityState]	
)
SELECT 
	L.[Id], D.[Index]	, L.[DocumentId], [BaseLineId], [ScalingFactor], L.[Memo], N'Unchanged'
FROM [dbo].[Lines] L
JOIN @D2Save D ON L.[DocumentId] = D.[Id]
INSERT INTO @E2Save (
	[Id], [LineIndex], [LineId], EntryNumber, OperationId,	AccountId, CustodyId, ResourceId, Direction, Amount, [Value], NoteId, [RelatedReference], [RelatedAgentId], [RelatedResourceId], [RelatedAmount], [EntityState]
)
SELECT
	E.[Id], L.[Index],	[LineId], EntryNumber, OperationId,	AccountId, CustodyId, ResourceId, Direction, Amount, [Value], NoteId, [RelatedReference], [RelatedAgentId], [RelatedResourceId], [RelatedAmount], N'Unchanged' AS [EntityState]
FROM [dbo].[Entries] E
JOIN @L2Save L ON E.[LineId] = L.[Id]

UPDATE @D2Save SET [StartDateTime] = '2018.01.02', [EntityState] = N'Updated'
UPDATE @E2Save SET [EntityState] = N'Deleted' WHERE [Index] = 1;
INSERT INTO @E2Save
([Id], [LineIndex], [LineId], EntryNumber, OperationId,		AccountId,			CustodyId,		ResourceId,	Direction, Amount, [Value],		NoteId,				[RelatedReference], [RelatedAgentId], [RelatedResourceId], [RelatedAmount], [EntityState]) VALUES
(NULL, 0,			1, 			4,			@Common, N'IssuedCapital',	@MohamadAkra,	@CommonStock,	-1,		1000,	2350000,	N'IssueOfEquity',	NULL,				NULL,				NULL,				NULL,			N'Inserted');
	
UPDATE @L2Save SET [EntityState] = N'Updated'
WHERE [EntityState] = N'Unchanged'
AND [Index] IN (
	SELECT [LineIndex] FROM @E2Save WHERE [EntityState] IN (N'Inserted', N'Updated', N'Deleted')
)

UPDATE @D2Save SET [EntityState] = N'Updated'
WHERE [EntityState] = N'Unchanged'
AND [Index] IN (
	SELECT [DocumentIndex] FROM @L2Save WHERE [EntityState] IN (N'Inserted', N'Updated', N'Deleted')
)
	
EXEC [dbo].[api_Documents__Save]
	@Documents = @D2Save, @Lines = @L2Save, @Entries = @E2Save,
	@ValidationErrorsJson = @ValidationErrorsJson OUTPUT,
	@DocumentsResultJson = @DResultJson OUTPUT, @LinesResultJson = @LResultJson OUTPUT, @EntriesResultJson = @EResultJson OUTPUT

IF @ValidationErrorsJson IS NOT NULL 
BEGIN
	Print 'Manual JV: Location 2'
	GOTO Err_Label;
END
) */


--select * FROM Documents where  Id in (Select Id from @Docs);
--SElect * from lines where DocumentId in (Select Id from @Docs);
--select * from entries where lineid in (select id from lines where DocumentId in (Select Id from @Docs));
