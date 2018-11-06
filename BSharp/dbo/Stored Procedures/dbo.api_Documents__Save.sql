﻿
CREATE PROCEDURE [dbo].[api_Documents__Save] 
	@Documents DocumentList READONLY, 
	@WideLines WideLineList READONLY, 
	@Lines LineList READONLY, 
	@Entries EntryList READONLY
AS
DECLARE
	@DocumentId int = 0,
	@TransactionType nvarchar(50),
	@ResponsibleAgentId int,
	@StartDateTime datetimeoffset(7),
	@EndDateTime datetimeoffset(7),	
	@Memo  nvarchar(255),

	@Operation1 int,
	@Reference1 nvarchar(50),
	@Account1 nvarchar(255),
	@Custody1 int, 
	@Resource1 int,
	@Direction1 smallint, 
	@Amount1 money,
	@Value1 money,
	@Note1 nvarchar(255),
	@RelatedReference1 nvarchar(50),
	@RelatedAgent1 int,
	@RelatedResource1 int,
	@RelatedAmount1 money,

	@Operation2 int,
	@Reference2 nvarchar(50),
	@Account2 nvarchar(255),
	@Custody2 int, 
	@Resource2 int,
	@Direction2 smallint, 
	@Amount2 money,
	@Value2 money,
	@Note2 nvarchar(255),
	@RelatedReference2 nvarchar(50),
	@RelatedAgent2 int,
	@RelatedResource2 int,
	@RelatedAmount2 money,

	@Operation3 int,
	@Reference3 nvarchar(50),
	@Account3 nvarchar(255),
	@Custody3 int, 
	@Resource3 int,
	@Direction3 smallint, 
	@Amount3 money,
	@Value3 money,
	@Note3 nvarchar(255),
	@RelatedReference3 nvarchar(50),
	@RelatedAgent3 int,
	@RelatedResource3 int,
	@RelatedAmount3 money,
	@LinesLocal LineList,
	@EntriesLocal EntryList,
	@EntriesTransit EntryList;
BEGIN TRY
	-- in memory validation, use LineTemplates Validation logic
	
	-- if no bulk db operation is needed, skip he next step
	-- in memory processing
	SET @DocumentId = (SELECT MIN(Id) FROM @Documents WHERE Id > @DocumentId);
	WHILE @DocumentId IS NOT NULL
	BEGIN
		DECLARE	@LineNumber int = 0;
		SET @LineNumber = (SELECT min(LineNumber) FROM @WideLines WHERE DocumentId = @DocumentId AND LineNumber > @LineNumber)
		WHILE @LineNumber IS NOT NULL
		BEGIN
			--Print 'Document ' + cast(@DocumentId as nvarchar(50)) + ', Line ' + Cast(@LineNumber as nvarchar(50));
			SELECT
				@DocumentId = DocumentId,
				@TransactionType = TransactionType,
				@ResponsibleAgentId = ResponsibleAgentId,
				@StartDateTime = StartDateTime,
				@EndDateTime = EndDateTime,
				@Memo = Memo,

				@Operation1 = Operation1,
				@Reference1 = Reference1,
				@Account1 = Account1,
				@Custody1 = Custody1, 
				@Resource1 = Resource1,
				@Direction1 = Direction1, 
				@Amount1 = Amount1,
				@Value1 = Value1,
				@Note1 = Note1,
				@RelatedReference1 = RelatedReference1,
				@RelatedAgent1 = RelatedAgent1,
				@RelatedResource1 = RelatedResource1,
				@RelatedAmount1 = RelatedAmount1,

				@Operation2 = Operation2,
				@Reference2 = Reference2,
				@Account2 = Account2,
				@Custody2 = Custody2, 
				@Resource2 = Resource2,
				@Direction2 = Direction2, 
				@Amount2 = Amount2,
				@Value2 = Value2,
				@Note2 = Note2,
				@RelatedReference2 = RelatedReference2,
				@RelatedAgent2 = RelatedAgent2,
				@RelatedResource2 = RelatedResource2,
				@RelatedAmount2 = RelatedAmount2,

				@Operation3 = Operation3,
				@Reference3 = Reference3,
				@Account3 = Account3,
				@Custody3 = Custody3, 
				@Resource3 = Resource3,
				@Direction3 = Direction3, 
				@Amount3 = Amount3,
				@Value3 = Value3,
				@Note3 = Note3,
				@RelatedReference3 = RelatedReference3,
				@RelatedAgent3 = RelatedAgent3,
				@RelatedResource3 = RelatedResource3,
				@RelatedAmount3 = RelatedAmount3
			FROM @WideLines
			WHERE DocumentId = @DocumentId AND LineNumber = @LineNumber

			INSERT INTO @EntriesTransit 
			EXEC [dbo].[sub_Line__Entries] 
				@DocumentId = @DocumentId,
				@TransactionType = @TransactionType,
				@LineNumber = @LineNumber,


				@Operation1 = @Operation1,
				@Reference1 = @Reference1,
				@Account1 = @Account1,
				@Custody1 = @Custody1, 
				@Resource1 = @Resource1,
				@Direction1 = @Direction1, 
				@Amount1 = @Amount1,
				@Value1 = @Value1,
				@Note1 = @Note1,
				@RelatedReference1 = @RelatedReference1,
				@RelatedAgent1 = @RelatedAgent1,
				@RelatedResource1 = @RelatedResource1,
				@RelatedAmount1 = @RelatedAmount1,

				@Operation2 = @Operation2,
				@Reference2 = @Reference2,
				@Account2 = @Account2,
				@Custody2 = @Custody2, 
				@Resource2 = @Resource2,
				@Direction2 = @Direction2, 
				@Amount2 = @Amount2,
				@Value2 = @Value2,
				@Note2 = @Note2,
				@RelatedReference2 = @RelatedReference2,
				@RelatedAgent2 = @RelatedAgent2,
				@RelatedResource2 = @RelatedResource2,
				@RelatedAmount2 = @RelatedAmount2,

				@Operation3 = @Operation3,
				@Reference3 = @Reference3,
				@Account3 = @Account3,
				@Custody3 = @Custody3, 
				@Resource3 = @Resource3,
				@Direction3 = @Direction3, 
				@Amount3 = @Amount3,
				@Value3 = @Value3,
				@Note3 = @Note3,
				@RelatedReference3 = @RelatedReference3,
				@RelatedAgent3 = @RelatedAgent3,
				@RelatedResource3 = @RelatedResource3,
				@RelatedAmount3 = @RelatedAmount3
			SET @LineNumber = (SELECT min(LineNumber) FROM @WideLines WHERE DocumentId = @DocumentId AND LineNumber > @LineNumber)
		END
		SET @DocumentId = (SELECT MIN(Id) FROM @Documents WHERE Id > @DocumentId);
	END

	IF EXISTS(SELECT * FROM @EntriesTransit)
	INSERT INTO @EntriesLocal
	EXEC [dbo].[bdb_Document_Values__Update] 
			@WideLines = @WideLines, @Entries = @EntriesTransit
	
	INSERT INTO @LinesLocal(DocumentId, LineNumber, ResponsibleAgentId, StartDateTime, EndDateTime, Memo)
	SELECT DocumentId, LineNumber, ResponsibleAgentId, StartDateTime, EndDateTime, Memo FROM @WideLines;

	INSERT INTO @LinesLocal SELECT * FROM @Lines;
	INSERT INTO @EntriesLocal SELECT * FROM @Entries;

	-- Bulk Update all null operations to business entity
	UPDATE @EntriesLocal
	SET OperationId = (SELECT min(Id) FROM dbo.Operations WHERE OperationType = N'BusinessEntity')
	WHERE OperationId IS NULL

	--Bulk Balance all lines having only one null value, by setting the value to the total of the other entries
	UPDATE E
	SET E.Value = -SN2.Net
	FROM @EntriesLocal E
	JOIN (
		SELECT DocumentId, LineNumber
		FROM @EntriesLocal
		WHERE Value IS NULL
		GROUP BY DocumentId, LineNumber
		HAVING COUNT(*) = 1
	) SN1 ON E.DocumentId = SN1.DocumentId AND E.LineNumber = SN1.LineNumber -- Single Null
	JOIN (
		SELECT DocumentId, LineNumber, SUM(Direction * Value) As Net
		FROM @EntriesLocal
		WHERE Value IS NOT NULL
		GROUP BY DocumentId, LineNumber
	) SN2 ON SN1.DocumentId = SN2.DocumentId AND SN1.LineNumber = SN2.LineNumber
	WHERE E.Value IS NULL

	-- Bulk validation

	-- Persist in Db
	EXEC ral_Documents_Lines_Entries__Insert @Documents = @Documents, @Lines = @LinesLocal, @Entries = @EntriesLocal
END TRY

BEGIN CATCH
	SELECT   /*
    ERROR_NUMBER() AS ErrorNumber  
    ,ERROR_SEVERITY() AS ErrorSeverity  
    ,ERROR_STATE() AS ErrorState  
    , */ERROR_PROCEDURE() AS ErrorProcedure  
    ,ERROR_LINE() AS ErrorLine  
    ,ERROR_MESSAGE() AS ErrorMessage; 
END CATCH