﻿CREATE TABLE [dbo].[Notes_H] (
	[TenantId]	INT,
	[C]			NVARCHAR (255),
	[P]			NVARCHAR (255),
	CONSTRAINT [PK_Notes_H] PRIMARY KEY NONCLUSTERED ([TenantId] ASC, [C] ASC, [P] ASC)
);