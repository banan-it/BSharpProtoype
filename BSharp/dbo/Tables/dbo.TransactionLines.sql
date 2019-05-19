﻿CREATE TABLE [dbo].[TransactionLines] (
	[TenantId]				INT,
	[Id]					INT IDENTITY,
	[DocumentId]			INT					NOT NULL,
	[TransactionLineType]	NVARCHAR (255)		NOT NULL,
	[TemplateLineId]		INT, -- depending on the line type, the user may/may not be allowed to edit
	[ScalingFactor]			FLOAT, -- Qty sold for Price list, Qty produced for BOM
	[Memo]					NVARCHAR (255),

	[Direction1]			SMALLINT		NOT NULL,
	[AccountId1]			INT,
	[ResponsibilityCenterId1]INT,
	[NoteId1]				NVARCHAR (255),
	[AgentAccountId1]		INT,
	[ResourceId1]			INT,
	[MoneyAmount1]			MONEY,
	[Mass1]					DECIMAL,
	[Volume1]				DECIMAL,
	[Count1]				DECIMAL,
	[Time1]					DECIMAL,
	[Value1]				VTYPE,
	[ExpectedClosingDate1]	DATETIMEOFFSET(7),
	[Reference1]			NVARCHAR (255),
	[Memo1]					NVARCHAR (255),
	[RelatedReference1]		NVARCHAR (255),
	[RelatedResourceId1]	INT,
	[RelatedAgentAccountId1]INT,
	[RelatedMoneyAmount1]	MONEY,
	[RelatedMass1]			DECIMAL,
	[RelatedVolume1]		DECIMAL,
	[RelatedCount1]			DECIMAL,
	[RelatedTime1]			DECIMAL,
	[RelatedValue1]			VTYPE,

	[Direction2]			SMALLINT		NOT NULL,
	[AccountId2]			INT,
	[ResponsibilityCenterId2]INT,
	[NoteId2]				NVARCHAR (255),
	[AgentAccountId2]		INT,
	[ResourceId2]			INT,
	[MoneyAmount2]			MONEY,
	[Mass2]					DECIMAL,
	[Volume2]				DECIMAL,
	[Count2]				DECIMAL,
	[Time2]					DECIMAL,
	[Value2]				VTYPE,
	[ExpectedClosingDate2]	DATETIMEOFFSET(7),
	[Reference2]			NVARCHAR (255),
	[Memo2]					NVARCHAR (255),
	[RelatedReference2]		NVARCHAR (255),
	[RelatedResourceId2]	INT,
	[RelatedAgentAccountId2]INT,
	[RelatedMoneyAmount2]	MONEY,
	[RelatedMass2]			DECIMAL,
	[RelatedVolume2]		DECIMAL,
	[RelatedCount2]			DECIMAL,
	[RelatedTime2]			DECIMAL,
	[RelatedValue2]			VTYPE,

	[Direction3]			SMALLINT		NOT NULL,
	[AccountId3]			INT,
	[ResponsibilityCenterId3]INT,
	[NoteId3]				NVARCHAR (255),
	[AgentAccountId3]		INT,
	[ResourceId3]			INT,
	[MoneyAmount3]			MONEY,
	[Mass3]					DECIMAL,
	[Volume3]				DECIMAL,
	[Count3]				DECIMAL,
	[Time3]					DECIMAL,
	[Value3]				VTYPE,
	[ExpectedClosingDate3]	DATETIMEOFFSET(7),
	[Reference3]			NVARCHAR (255),
	[Memo3]					NVARCHAR (255),
	[RelatedReference3]		NVARCHAR (255),
	[RelatedResourceId3]	INT,
	[RelatedAgentAccountId3]INT,
	[RelatedMoneyAmount3]	MONEY,
	[RelatedMass3]			DECIMAL,
	[RelatedVolume3]		DECIMAL,
	[RelatedCount3]			DECIMAL,
	[RelatedTime3]			DECIMAL,
	[RelatedValue3]			VTYPE,

	[Direction4]			SMALLINT		NOT NULL,
	[AccountId4]			INT,
	[ResponsibilityCenterId4]INT,
	[NoteId4]				NVARCHAR (255),
	[AgentAccountId4]		INT,
	[ResourceId4]			INT,
	[MoneyAmount4]			MONEY,
	[Mass4]					DECIMAL,
	[Volume4]				DECIMAL,
	[Count4]				DECIMAL,
	[Time4]					DECIMAL,
	[Value4]				VTYPE,
	[ExpectedClosingDate4]	DATETIMEOFFSET(7),
	[Reference4]			NVARCHAR (255),
	[Memo4]					NVARCHAR (255),
	[RelatedReference4]		NVARCHAR (255),
	[RelatedResourceId4]	INT,
	[RelatedAgentAccountId4]INT,
	[RelatedMoneyAmount4]	MONEY,
	[RelatedMass4]			DECIMAL,
	[RelatedVolume4]		DECIMAL,
	[RelatedCount4]			DECIMAL,
	[RelatedTime4]			DECIMAL,
	[RelatedValue4]			VTYPE,

	[CreatedAt]				DATETIMEOFFSET(7)	NOT NULL,
	[CreatedById]			INT					NOT NULL,
	[ModifiedAt]			DATETIMEOFFSET(7)	NOT NULL, 
	[ModifiedById]			INT					NOT NULL,
	CONSTRAINT [PK_TransactionLines] PRIMARY KEY CLUSTERED ([TenantId] ASC, [Id] ASC),
	CONSTRAINT [FK_TransactionLines__Documents] FOREIGN KEY ([TenantId], [DocumentId]) REFERENCES [dbo].[Documents] ([TenantId], [Id]) ON DELETE CASCADE,
	CONSTRAINT [FK_TransactionLines__TransactionLineTypes] FOREIGN KEY ([TenantId], [TransactionLineType]) REFERENCES [dbo].[LineTypes] ([TenantId], [Id]) ON DELETE CASCADE,
	CONSTRAINT [FK_TransactionLines__TemplateLines] FOREIGN KEY ([TenantId], [TemplateLineId]) REFERENCES [dbo].[TemplateLines] ([TenantId], [Id]),
	CONSTRAINT [FK_TransactionLines__CreatedById] FOREIGN KEY ([TenantId], [CreatedById]) REFERENCES [dbo].[LocalUsers] ([TenantId], [Id]),
	CONSTRAINT [FK_TransactionLines__ModifiedById] FOREIGN KEY ([TenantId], [ModifiedById]) REFERENCES [dbo].[LocalUsers] ([TenantId], [Id])
);
GO
CREATE INDEX [IX_TransactionLines__DocumentId] ON [dbo].[TransactionLines]([TenantId] ASC, [DocumentId] ASC);
GO
ALTER TABLE [dbo].[TransactionLines] ADD CONSTRAINT [DF_TransactionLines__TenantId]  DEFAULT (CONVERT(INT, SESSION_CONTEXT(N'TenantId'))) FOR [TenantId];
GO
ALTER TABLE [dbo].[TransactionLines] ADD CONSTRAINT [DF_TransactionLines__CreatedAt]  DEFAULT (SYSDATETIMEOFFSET()) FOR [CreatedAt];
GO
ALTER TABLE [dbo].[TransactionLines] ADD CONSTRAINT [DF_TransactionLines__CreatedById]  DEFAULT (CONVERT(INT, SESSION_CONTEXT(N'UserId'))) FOR [CreatedById]
GO
ALTER TABLE [dbo].[TransactionLines] ADD CONSTRAINT [DF_TransactionLines__ModifiedAt]  DEFAULT (SYSDATETIMEOFFSET()) FOR [ModifiedAt];
GO
ALTER TABLE [dbo].[TransactionLines] ADD CONSTRAINT [DF_TransactionLines__ModifiedById]  DEFAULT (CONVERT(INT, SESSION_CONTEXT(N'UserId'))) FOR [ModifiedById]
GO