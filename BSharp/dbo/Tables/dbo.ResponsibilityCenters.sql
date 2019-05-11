﻿CREATE TABLE [dbo].[ResponsibilityCenters] (
/*
WSI (I)
	0 Executive Office (includes Internal audit)  (C, A)
		00 Manager
		01 Internat Audit (C, A)
	1 Marketing & Sales (R, S), 
		10 AG Office
		11 Bole Office (girls salaries, office rental)
	2 Production (C, O), -- each stage consumes Direct Materials, Services, Labor, Machines in addition to output of previous stage
		20 Manager (Mesfin salary and Laptop depreciation)
		21 Slitting (HR, CR)
		22 pipe making 
		23 Cut to size
	3 Maintenance (C, O) (labor), apportioned to other functions
	4 Materials and Purchases (C, A/S/O)
	5 MIS (C, A)
	6 HR & General services, (C. A)(utilities, labor, consumables)
	7 Finance, (C, A) (labor, education, stationery, interest expenses)
	8 Coffee Processing (I, A/S/O)

	Legend: C: Cost center, R: Revenue Center, P: Profit center, I: Investment center
	A: leftover expenses are administrative, S: leftover are selling and distribution, O: leftover are Cost of Sales
We identify business units as those whose managers may potentially prepare and submit a yearly budget. Eventually, those managers signatures 
are required for expense approvals
We may go further down by identifying activities in a business unit, and allocate expenses to those, for more accurate cost accounting
Budgets table: Id, Business unit, Direction, Account, Resource, ValueMeasure, Value, Period
Produced: Business Unit (sales), Direction (Debit), Account (FG inventory), Resource ...
Sold: Business Unit (sales), Direction (Debit), Account (Revenues), Resource ...
Closing FG Balance: Account(FG inventory), Resource, ValueMeasure Balance, Value Balance
Opening FG Balance: Account(FG inventory), Resource, ValueMeasure Balance, Value Balance
Produced = Sold + Closing - Opening

*/
-- some operations are used in the line corresponding to production event
	[TenantId]					INT,
	[Id]						INT					IDENTITY,
	[ResponsibilityCenterType]	NVARCHAR (255)		NOT NULL, -- Investment, Profit, Revenue, Cost
	[Name]						NVARCHAR (255)		NOT NULL,
	[Name2]						NVARCHAR (255),
	[Name3]						NVARCHAR (255),
-- (IFRS 8) Profit or Investment Center, Performance regularly reviewed by CODM, discrete financial information is available
	[IsOperatingSegment]		BIT					NOT NULL DEFAULT (0), -- on each path from root to leaf, at most one O/S
	[IsActive]					BIT					NOT NULL DEFAULT (1),
	[ParentId]					INT, -- Only leaves can have data. Parents are represented by an extra leaf.
	[Code]						NVARCHAR (255),
-- Optional. used for convenient reporting
	[OperationId]				INT, -- e.g., general, admin, S&M, HR, finance, production, maintenance
	[ProductCategoryId]			INT, -- e.g., general, sales, services OR, Steel, Real Estate, Coffee, ..
	[GeographicRegionId]		INT, -- e.g., general, Oromia, Merkato, Kersa
	[CustomerSegmentId]			INT, -- e.g., general, then corporate, individual or M, F or Adult youth, etc...
	[TaxSegmentId]				INT, -- e.g., general, existing (30%), expansion (0%)

	[CreatedAt]					DATETIMEOFFSET(7)	NOT NULL,
	[CreatedById]				INT					NOT NULL,
	[ModifiedAt]				DATETIMEOFFSET(7)	NOT NULL, 
	[ModifiedById]				INT					NOT NULL,
	CONSTRAINT [PK_Operations] PRIMARY KEY CLUSTERED ([TenantId] ASC, [Id] ASC),
	CONSTRAINT [FK_Operations_Operations] FOREIGN KEY ([TenantId], [ParentId]) REFERENCES [dbo].[ResponsibilityCenters] ([TenantId], [Id]),
	CONSTRAINT [FK_Operations_CreatedById] FOREIGN KEY ([TenantId], [CreatedById]) REFERENCES [dbo].[LocalUsers] ([TenantId], [Id]),
	CONSTRAINT [FK_Operations_ModifiedById] FOREIGN KEY ([TenantId], [ModifiedById]) REFERENCES [dbo].[LocalUsers] ([TenantId], [Id])
);
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Operations__Name]
  ON [dbo].[ResponsibilityCenters]([TenantId] ASC, [Name] ASC);
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Operations__Name2]
  ON [dbo].[ResponsibilityCenters]([TenantId] ASC, [Name2] ASC) WHERE [Name2] IS NOT NULL;
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Operations__Name3]
  ON [dbo].[ResponsibilityCenters]([TenantId] ASC, [Name3] ASC) WHERE [Name3] IS NOT NULL;
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Operations__Code]
  ON [dbo].[ResponsibilityCenters]([TenantId] ASC, [Code] ASC) WHERE [Code] IS NOT NULL;
GO
ALTER TABLE [dbo].[ResponsibilityCenters] ADD CONSTRAINT [DF_ResponsibilityCenters__TenantId]  DEFAULT (CONVERT(INT, SESSION_CONTEXT(N'TenantId'))) FOR [TenantId];
GO
ALTER TABLE [dbo].[ResponsibilityCenters] ADD CONSTRAINT [DF_ResponsibilityCenters__CreatedAt]  DEFAULT (SYSDATETIMEOFFSET()) FOR [CreatedAt];
GO
ALTER TABLE [dbo].[ResponsibilityCenters] ADD CONSTRAINT [DF_ResponsibilityCenters__CreatedById]  DEFAULT (CONVERT(INT,SESSION_CONTEXT(N'UserId'))) FOR [CreatedById]
GO
ALTER TABLE [dbo].[ResponsibilityCenters] ADD CONSTRAINT [DF_ResponsibilityCenters__ModifiedAt]  DEFAULT (SYSDATETIMEOFFSET()) FOR [ModifiedAt];
GO
ALTER TABLE [dbo].[ResponsibilityCenters] ADD CONSTRAINT [DF_ResponsibilityCenters__ModifiedById]  DEFAULT (CONVERT(INT,SESSION_CONTEXT(N'UserId'))) FOR [ModifiedById]
GO