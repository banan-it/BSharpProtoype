﻿CREATE TABLE [dbo].[DocumentTypes] ( -- table managed by Banan, no UI for it in B11
	[TenantId]		INT,
	[Id]			NVARCHAR (255) NOT NULL,
	[Description]	NVARCHAR (255),
	[Description2]	NVARCHAR (255),
	CONSTRAINT [PK_DocumentTypes] PRIMARY KEY CLUSTERED ([TenantId] ASC,[Id] ASC)
);