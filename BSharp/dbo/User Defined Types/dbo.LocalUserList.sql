﻿CREATE TYPE [dbo].[LocalUserList] AS TABLE (
	[Index]				INT,
	[Id]				UNIQUEIDENTIFIER NOT NULL DEFAULT NEWSEQUENTIALID(),
	[Name]				NVARCHAR (255)	NOT NULL,
	[Name2]				NVARCHAR (255),
	[Name3]				NVARCHAR (255),
	[PreferredLanguage] NCHAR(2)		NOT NULL DEFAULT (N'en'), 
	[ProfilePhoto]		VARBINARY (MAX),
	[AgentId]			UNIQUEIDENTIFIER,
	[EntityState]		NVARCHAR (255)	NOT NULL DEFAULT(N'Inserted'),
	PRIMARY KEY ([Index]),
	CHECK ([EntityState] IN (N'Unchanged', N'Inserted', N'Updated', N'Deleted'))
);