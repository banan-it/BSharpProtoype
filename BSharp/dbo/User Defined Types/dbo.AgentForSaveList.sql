﻿CREATE TYPE [dbo].[AgentForSaveList] AS TABLE
(
	[Index]						INT					IDENTITY(0, 1),
	[Id]						INT,
	[AgentType]					NVARCHAR (255)		NOT NULL,
    [Name]						NVARCHAR (255)		NOT NULL,
	[Code]						NVARCHAR (255),
    [Address]			NVARCHAR (255),
    [BirthDateTime]				DATETIMEOFFSET (7),
	[IsRelated]					BIT					NOT NULL DEFAULT (0),
    [UserId]					NVARCHAR (450),
    [TaxIdentificationNumber]	NVARCHAR (255),
    [Title]						NVARCHAR (255),
    [Gender]					NCHAR (1),
	[EntityState]				NVARCHAR(255)		NOT NULL DEFAULT(N'Inserted'), -- Unchanged, Inserted, Updated, Deleted.
    PRIMARY KEY CLUSTERED ([Index] ASC),
	CHECK ([AgentType] IN (N'Individual', N'Organization', N'OrganizationUnit')),
	CHECK ([EntityState] <> N'Inserted' OR [Id] IS NULL)
);
