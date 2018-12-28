﻿CREATE TYPE [dbo].[WideLineForSaveList2] AS TABLE (			
	[LineIndex]				INT,
	[LineId]				INT,
	[DocumentIndex]			INT				NOT NULL,
	[DocumentId]			INT,
	[LineType]				NVARCHAR (255)	NOT NULL,
	[BaseLineId]			INT, -- this is like FunctionId, good for linear functions.
	[ScalingFactor]			FLOAT, -- Qty sold for Price list, Qty produced for BOM, throughput rate for oil well.
	[Memo]					NVARCHAR (255),
	[EntryId1]				INT,
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
	[EntryId2]				INT,
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
	[EntryId3]				INT,
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
	[EntityState]			NVARCHAR(255)	NOT NULL DEFAULT(N'Inserted'),
	PRIMARY KEY CLUSTERED ([LineIndex] ASC),
	CHECK ([EntityState] IN (N'Unchanged', N'Inserted', N'Updated', N'Deleted')),
	CHECK ([EntityState] <> N'Inserted' OR [LineId] IS NULL)	
);
