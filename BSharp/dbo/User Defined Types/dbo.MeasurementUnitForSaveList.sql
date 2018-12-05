﻿CREATE TYPE [dbo].[MeasurementUnitForSaveList] AS TABLE
(
	[Index]			INT				IDENTITY(0, 1),
	[Id]			INT,
    [UnitType]		NVARCHAR (255)	NOT NULL,
    [Name]			NVARCHAR (255)	NOT NULL,
    [UnitAmount]	FLOAT (53)		NOT NULL,
    [BaseAmount]	FLOAT (53)		NOT NULL,
	[EntityState]	NVARCHAR(255)	NOT NULL DEFAULT(N'Inserted'),
    [Code]			NVARCHAR (255),
    PRIMARY KEY CLUSTERED ([Index] ASC),
	CHECK ([UnitType] IN (N'Pure', N'Time', N'Distance', N'Count', N'Mass', N'Volume', N'Money')),
	CHECK ([EntityState] <> N'Inserted' OR [Id] IS NULL)
)