﻿CREATE TYPE [dbo].[WideLineList] AS TABLE (
    [DocumentId]         INT                NOT NULL,
	[TransactionType]    NVARCHAR (50)      NOT NULL,
    [LineNumber]         INT                NOT NULL,
    [ResponsibleAgentId] INT                NULL,
    [StartDateTime]      DATETIMEOFFSET (7) NULL,
    [EndDateTime]        DATETIMEOFFSET (7) NULL,
	[Memo]				 NVARCHAR (255)     NULL,
    [Operation1]         INT                NULL,
    [Reference1]         NVARCHAR (50)      NULL,
    [Account1]           NVARCHAR (255)     NULL,
    [Custody1]           INT                NULL,
    [Resource1]          INT                NULL,
    [Direction1]         SMALLINT           NULL,
    [Amount1]            MONEY              NULL,
    [Value1]             MONEY              NULL,
    [Note1]              NVARCHAR (255)     NULL,
    [RelatedReference1]  NVARCHAR (50)      NULL,
    [RelatedAgent1]      INT                NULL,
    [RelatedResource1]   INT                NULL,
    [RelatedAmount1]     MONEY              NULL,
    [Operation2]         INT                NULL,
    [Reference2]         NVARCHAR (50)      NULL,
    [Account2]           NVARCHAR (255)     NULL,
    [Custody2]           INT                NULL,
    [Resource2]          INT                NULL,
    [Direction2]         SMALLINT           NULL,
    [Amount2]            MONEY              NULL,
    [Value2]             MONEY              NULL,
    [Note2]              NVARCHAR (255)     NULL,
    [RelatedReference2]  NVARCHAR (50)      NULL,
    [RelatedAgent2]      INT                NULL,
    [RelatedResource2]   INT                NULL,
    [RelatedAmount2]     MONEY              NULL,
    [Operation3]         INT                NULL,
    [Reference3]         NVARCHAR (50)      NULL,
    [Account3]           NVARCHAR (255)     NULL,
    [Custody3]           INT                NULL,
    [Resource3]          INT                NULL,
    [Direction3]         SMALLINT           NULL,
    [Amount3]            MONEY              NULL,
    [Value3]             MONEY              NULL,
    [Note3]              NVARCHAR (255)     NULL,
    [RelatedReference3]  NVARCHAR (50)      NULL,
    [RelatedAgent3]      INT                NULL,
    [RelatedResource3]   INT                NULL,
    [RelatedAmount3]     MONEY              NULL,
    PRIMARY KEY CLUSTERED ([DocumentId] ASC, [LineNumber] ASC));

