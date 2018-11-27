﻿CREATE TYPE [dbo].[SettingList] AS TABLE
(
    [Field]		NVARCHAR (255)  NOT NULL,
    [Value]		NVARCHAR (1024) NOT NULL,
	[Status]	NVARCHAR(10) NOT NULL DEFAULT(N'Inserted'),
	PRIMARY KEY CLUSTERED ([Field] ASC)
);
