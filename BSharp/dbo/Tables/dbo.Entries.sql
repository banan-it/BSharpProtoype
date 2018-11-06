﻿CREATE TABLE [dbo].[Entries] (
    [DocumentId]        INT            NOT NULL,
    [LineNumber]        INT            NOT NULL,
    [EntryNumber]       INT            NOT NULL,
    [OperationId]       INT            NOT NULL,
    [Reference]         NVARCHAR (50)  NULL,
    [AccountId]         NVARCHAR (255) NOT NULL,
    [CustodyId]         INT            NOT NULL,
    [ResourceId]        INT            NOT NULL,
    [Direction]         SMALLINT       NOT NULL,
    [Amount]            MONEY          NOT NULL,
    [Value]             MONEY          NOT NULL,
    [NoteId]            NVARCHAR (255) NULL,
    [RelatedReference]  NVARCHAR (50)  NULL,
    [RelatedAgentId]    INT            NULL,
    [RelatedResourceId] INT            NULL,
    [RelatedAmount]     MONEY          NULL,
    CONSTRAINT [PK_LineItems] PRIMARY KEY CLUSTERED ([DocumentId] ASC, [LineNumber] ASC, [EntryNumber] ASC),
    CONSTRAINT [CK_Entries_Direction] CHECK ([Direction]=(1) OR [Direction]=(-1)),
    CONSTRAINT [FK_Entries_Accounts] FOREIGN KEY ([AccountId]) REFERENCES [dbo].[Accounts] ([Id]) ON UPDATE CASCADE,
    CONSTRAINT [FK_Entries_Custodies] FOREIGN KEY ([CustodyId]) REFERENCES [dbo].[Custodies] ([Id]),
    CONSTRAINT [FK_Entries_Lines] FOREIGN KEY ([DocumentId], [LineNumber]) REFERENCES [dbo].[Lines] ([DocumentId], [LineNumber]) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT [FK_Entries_Notes] FOREIGN KEY ([NoteId]) REFERENCES [dbo].[Notes] ([Id]) ON UPDATE CASCADE,
    CONSTRAINT [FK_Entries_Operations] FOREIGN KEY ([OperationId]) REFERENCES [dbo].[Operations] ([Id]),
    CONSTRAINT [FK_Entries_Resources] FOREIGN KEY ([ResourceId]) REFERENCES [dbo].[Resources] ([Id])
);

