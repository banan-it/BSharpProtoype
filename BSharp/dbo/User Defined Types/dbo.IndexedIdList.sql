﻿CREATE TYPE [dbo].[IndexedIdList] AS TABLE
(
	[Index] INT,
	[Id] INT
    PRIMARY KEY CLUSTERED ([Index] ASC, [Id] ASC)
);
