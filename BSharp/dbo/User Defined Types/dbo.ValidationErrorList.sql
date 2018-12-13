﻿CREATE TYPE [dbo].[ValidationErrorList] AS TABLE (
	[Key]			NVARCHAR (255),
  [ErrorName]		NVARCHAR (255),
	[Argument1]		NVARCHAR (255),
	[Argument2]		NVARCHAR (255),
	[Argument3]		NVARCHAR (255),
	[Argument4]		NVARCHAR (255),
	[Argument5]		NVARCHAR (255),
	PRIMARY KEY CLUSTERED ([Key] ASC, [ErrorName] ASC)
);
