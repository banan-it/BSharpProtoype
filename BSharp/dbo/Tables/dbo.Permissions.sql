﻿CREATE TABLE [dbo].[Permissions] (
	[TenantId]		INT,
	[Id]			INT					IDENTITY(1,1),
	[RoleId]		INT					NOT NULL,
	[ViewId]		NVARCHAR(255)		NOT NULL,
	[Level]			NVARCHAR(255)		NOT NULL,
	[Criteria]		NVARCHAR(1024), -- compiles into LINQ expression to filter the applicability
	[Memo]			NVARCHAR(255),
	[CreatedAt]		DATETIMEOFFSET(7)	NOT NULL,
	[CreatedBy]		NVARCHAR(450)		NOT NULL,
	[ModifiedAt]	DATETIMEOFFSET(7)	NOT NULL, 
	[ModifiedBy]	NVARCHAR(450)		NOT NULL,
	CONSTRAINT [PK_Permissions] PRIMARY KEY CLUSTERED ([TenantId] ASC, [Id] ASC),
	CONSTRAINT [CK_Permissions_Level] CHECK ([Level] IN (N'Read', N'Create', N'ReadAndCreate', N'Update', N'Sign')),
	CONSTRAINT [FK_Permissions_Roles] FOREIGN KEY ([TenantId], [RoleId]) REFERENCES [dbo].[Roles] ([TenantId], [Id]),
	CONSTRAINT [FK_Permissions_CreatedBy] FOREIGN KEY ([TenantId], [CreatedBy]) REFERENCES [dbo].[Users] ([TenantId], [Id]),
	CONSTRAINT [FK_Permissions_ModifiedBy] FOREIGN KEY ([TenantId], [ModifiedBy]) REFERENCES [dbo].[Users] ([TenantId], [Id])

);
GO
CREATE INDEX [IX_Permissions__RoleId] ON [dbo].[Roles]([TenantId] ASC, [Id] ASC);
GO