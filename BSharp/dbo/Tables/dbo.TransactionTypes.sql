﻿CREATE TABLE [dbo].[TransactionTypes] (
    [Id]                 NVARCHAR (50)  NOT NULL,
    [IsInstant]          BIT            NOT NULL,
    CONSTRAINT [PK_TransactionTypes] PRIMARY KEY CLUSTERED ([Id] ASC),
);
