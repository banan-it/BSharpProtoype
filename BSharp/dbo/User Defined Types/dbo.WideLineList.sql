﻿CREATE TYPE [dbo].[WideLineList] AS TABLE (
    [LineId]				INT,
    [DocumentId]			INT					NOT NULL,
	[TransactionType]		NVARCHAR (255)      NOT NULL,
    [ResponsibleAgentId]	INT,
    [StartDateTime]			DATETIMEOFFSET (7),
    [EndDateTime]			DATETIMEOFFSET (7),
	[BaseLineId]			INT, -- this is like FunctionId, good for linear functions.
	[ScalingFactor]			FLOAT, -- Qty sold for Price list, Qty produced for BOM, throughput rate for oil well.
	[Memo]					NVARCHAR (255),
    [Operation1]			INT,
    [Reference1]			NVARCHAR (255),
    [Account1]				NVARCHAR (255),
    [Custody1]				INT,
    [Resource1]				INT,
    [Direction1]			SMALLINT,
    [Amount1]				MONEY,
    [Value1]				MONEY,
    [Note1]					NVARCHAR (255),
    [RelatedReference1]		NVARCHAR (255),
    [RelatedAgent1]			INT,
    [RelatedResource1]		INT,
    [RelatedAmount1]		MONEY,
    [Operation2]			INT,
    [Reference2]			NVARCHAR (255),
    [Account2]				NVARCHAR (255),
    [Custody2]				INT,
    [Resource2]				INT,
    [Direction2]			SMALLINT,
    [Amount2]				MONEY,
    [Value2]				MONEY,
    [Note2]					NVARCHAR (255),
    [RelatedReference2]		NVARCHAR (255),
    [RelatedAgent2]			INT,
    [RelatedResource2]		INT,
    [RelatedAmount2]		MONEY,
    [Operation3]			INT,
    [Reference3]			NVARCHAR (255),
    [Account3]				NVARCHAR (255),
    [Custody3]				INT,
    [Resource3]				INT,
    [Direction3]			SMALLINT,
    [Amount3]				MONEY,
    [Value3]				MONEY,
    [Note3]					NVARCHAR (255),
    [RelatedReference3]		NVARCHAR (255),
    [RelatedAgent3]			INT,
    [RelatedResource3]		INT,
    [RelatedAmount3]		MONEY,
	[Status]				NVARCHAR(255)		NOT NULL DEFAULT(N'Inserted'), -- Unchanged, Inserted, Updated, Deleted.
	[TemporaryId]			INT					NOT NULL,
    PRIMARY KEY CLUSTERED ([LineId] ASC));

