﻿CREATE TYPE [dbo].[EntryList] AS TABLE (
	[Index]				INT,
	[LineIndex]			INT					NOT NULL,
	[Id]				INT,
	[LineId]			INT,
	[EntryNumber]		INT					NOT NULL,
	[OperationId]		INT,
	[Reference]			NVARCHAR (255),
	[AccountId]			NVARCHAR (255),
	[CustodyId]			INT,
	[ResourceId]		INT,
	[Direction]			SMALLINT,
	[Amount]			MONEY,
	[Value]				VTYPE,
	[NoteId]			NVARCHAR (255),
	[RelatedReference]	NVARCHAR (255),
	[RelatedAgentId]	INT,
	[RelatedResourceId]	INT,
	[RelatedAmount]		MONEY,
	[EntityState]		NVARCHAR(255)		NOT NULL DEFAULT(N'Inserted'),
	PRIMARY KEY ([Index] ASC),
	INDEX IX_EntryList_LineIndex (LineIndex),
	CHECK ([Direction] IN (-1, 1)),
	CHECK ([EntityState] IN (N'Unchanged', N'Inserted', N'Updated', N'Deleted')),
	CHECK ([EntityState] <> N'Inserted' OR [Id] IS NULL)
);
