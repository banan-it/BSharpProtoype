﻿CREATE TABLE [dbo].[Accounts] (
	[TenantId]					INT,
	[Id]						INT					NOT NULL IDENTITY,
	[Node]						HIERARCHYID,
	[Level]						AS [Node].GetLevel(),
	[ParentNode]				AS [Node].GetAncestor(1),
	-- IfrsAccountId becomes immutable once account appears in a (draft/posted) document
	[IfrsAccountId]				NVARCHAR (255)		NOT NULL, -- Ifrs Concept
	[IsAggregate]				BIT					NOT NULL,
	[IsActive]					BIT					NOT NULL DEFAULT (1),
	[Name]						NVARCHAR (255)		NOT NULL,
	[Name2]						NVARCHAR (255),
	[Name3]						NVARCHAR (255),
	[Code]						NVARCHAR (255),
/*
	An application-wide settings specify whether to activate the following columns:
	[IsActiveIfrsNote], when wanting to generate specific Ifrs statements and notes
	[IsActiveResponsibilityCenter], when using cost accounting
	[IsActiveResource] when using inventory, fixed assets, or services modules
	[IsActiveExpectedSettlingDate] when tracking expiry dates and due dates
	[IsActiveAgentAccount], when using warehouses, or subsidiaries for receivable or payables
	[IsActiveRelaredResource], when activating certain tax reports
	[IsActiveRelatedAgentAccount], when activating certain tax reports
*/

/*
	-- For the following columns, see the corresponding columns in table TransactionEntries for documentation
	-- We show a note to the user: for the columns below, if the value is set at the account level
	-- then it overrides what is set at the entries level.
	If IsFixed = false, the user is expected to specify it in the journal entry line items
*/

--	This field will show only if two requirements are satisfied:
--	IsActiveIfrsNote is true, and if IfrsAccount specs requires specifying Ifrs Note in journal entry line item (JE.LI)
	[IfrsNoteId]				NVARCHAR (255),		-- includes Expense by function

--	These fields will show only if IsActiveResponsibilityCenter=True, and if IfrsAccount specs require it in JE.Li
	[ResponsibilityCenterIsFixed]BIT				NOT NULL DEFAULT (1),
	[ResponsibilityCenterId]	INT,

-- These fields will show only if IsActiveAgentAccount, and if IfrsAccount specs require it
	[AgentAccountIsFixed]		BIT					NOT NULL DEFAULT (1),
	[AgentAccountId]			INT,

-- These fields will show only if IsActiveResource, and if IfrsAccount specs require it
	[ResourceIsFixed]			BIT					NOT NULL DEFAULT (1),
	[ResourceId]				INT,

-- These fields will show only if IsActiveExpectedSettlingDate, and if IfrsAccount specs require it
	[ExpectedSettlingDateIsFixed]BIT				NOT NULL DEFAULT (0),
	[ExpectedSettlingDate]		DATETIME2(7),

	-- Audit details
	[CreatedAt]					DATETIMEOFFSET(7)	NOT NULL,
	[CreatedById]				INT					NOT NULL,
	[ModifiedAt]				DATETIMEOFFSET(7)	NOT NULL, 
	[ModifiedById]				INT					NOT NULL,
	CONSTRAINT [PK_Accounts] PRIMARY KEY CLUSTERED ([TenantId], [Id]),
	CONSTRAINT [FK_Accounts__IfrsAccountId] FOREIGN KEY ([TenantId], [IfrsAccountId]) REFERENCES [dbo].[IfrsAccounts] ([TenantId], [Id]),
	CONSTRAINT [FK_Accounts__IfrsNoteId] FOREIGN KEY ([TenantId], [IfrsNoteId]) REFERENCES [dbo].[IfrsNotes] ([TenantId], [Id]),
	CONSTRAINT [FK_Accounts__ResponsibilityCenterId] FOREIGN KEY ([TenantId], [ResponsibilityCenterId]) REFERENCES [dbo].[ResponsibilityCenters] ([TenantId], [Id]),
	CONSTRAINT [FK_Accounts__AgentAccountId] FOREIGN KEY ([TenantId], [AgentAccountId]) REFERENCES [dbo].[AgentAccounts] ([TenantId], [Id]),
	CONSTRAINT [FK_Accounts__ResourceId] FOREIGN KEY ([TenantId], [ResourceId]) REFERENCES [dbo].[Resources] ([TenantId], [Id]),
	CONSTRAINT [FK_Accounts__CreatedById] FOREIGN KEY ([TenantId], [CreatedById]) REFERENCES [dbo].[LocalUsers] ([TenantId], [Id]),
	CONSTRAINT [FK_Accounts__ModifiedById] FOREIGN KEY ([TenantId], [ModifiedById]) REFERENCES [dbo].[LocalUsers] ([TenantId], [Id])
);
GO
CREATE UNIQUE INDEX [IX_Accounts__Node] ON [dbo].[Accounts]([TenantId], [Node]);
GO
CREATE INDEX [IX_Accounts__Level_Node] ON [dbo].[Accounts]([TenantId], [Level], [Node]);
GO
CREATE UNIQUE INDEX [IX_Accounts__Code] ON [dbo].[Accounts]([TenantId], [Code]) WHERE [Code] IS NOT NULL;
GO
ALTER TABLE [dbo].[Accounts] ADD CONSTRAINT [DF_Accounts__TenantId]  DEFAULT (CONVERT(INT, SESSION_CONTEXT(N'TenantId'))) FOR [TenantId];
GO
ALTER TABLE [dbo].[Accounts] ADD CONSTRAINT [DF_Accounts__CreatedAt]  DEFAULT (SYSDATETIMEOFFSET()) FOR [CreatedAt];
GO
ALTER TABLE [dbo].[Accounts] ADD CONSTRAINT [DF_Accounts__CreatedById]  DEFAULT (CONVERT(INT, SESSION_CONTEXT(N'UserId'))) FOR [CreatedById]
GO
ALTER TABLE [dbo].[Accounts] ADD CONSTRAINT [DF_Accounts__ModifiedAt]  DEFAULT (SYSDATETIMEOFFSET()) FOR [ModifiedAt];
GO
ALTER TABLE [dbo].[Accounts] ADD CONSTRAINT [DF_Accounts__ModifiedById]  DEFAULT (CONVERT(INT, SESSION_CONTEXT(N'UserId'))) FOR [ModifiedById]
GO