﻿CREATE FUNCTION [dbo].[fi_Journal] (-- SELECT * FROM [dbo].[fi_Journal]('01.01.2015','01.01.2020')
	@fromDate Datetime = '2000.01.01', 
	@toDate Datetime = '2100.01.01'
) RETURNS TABLE
AS
RETURN
	WITH
	IntegerList AS ( -- can be defined recursively, or simply read from a table
		SELECT 0 As I UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION
		SELECT 5 As I UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9
	)
	SELECT
		V.[Id],
		V.[DocumentId],
		CONVERT(NVARCHAR (255), V.[DocumentDate], 102) AS DocumentDate,
		V.[SerialNumber],
		V.[TransactionType],
		V.[IsSystem],
		V.[Direction],
		V.[AccountId],
		V.[IFRSAccountId],
		V.[IFRSNoteId],
		V.[ResponsibilityCenterId],
		-- [OperationId],
		-- [ProductCategoryId],
		-- [GeographicRegionId],
		-- [CustomerSegmentId],
		-- [TaxSegmentId],
		V.[AgentAccountId],
		V.[ResourceId],
		V.[Quantity],
		V.[MoneyAmount],
		V.[Mass],
		V.[Mass] * MU.[BaseAmount] / MU.[UnitAmount] As NormalizedMass,
		V.[Volume], 
		V.[Volume] * VU.[BaseAmount] / VU.[UnitAmount] As NormalizedVolume,
		V.[Count],
		V.[Volume] * CU.[BaseAmount] / CU.[UnitAmount] As NormalizedCount,
		V.[Time],
		V.[Value],
		V.[ExpectedSettlingDate],
		V.[Reference],
		V.[Memo],
		V.[RelatedReference],
		V.[RelatedResourceId],
		V.[RelatedAgentAccountId],
		V.[RelatedResponsibilityCenterId],
		V.[RelatedQuantity],
		V.[RelatedMoneyAmount],
		V.[RelatedMass],
		V.[RelatedVolume],
		V.[RelatedCount],
		V.[RelatedTime],
		V.[RelatedValue]
	FROM dbo.[TransactionEntriesView] V
	JOIN dbo.Resources R ON V.ResourceId = R.Id
	JOIN dbo.MeasurementUnits MU ON R.MassUnitId = MU.Id
	JOIN dbo.MeasurementUnits VU ON R.VolumeUnitId = VU.Id
	JOIN dbo.MeasurementUnits CU ON R.CountUnitId = CU.Id
	WHERE V.[Frequency]		= N'OneTime'
	AND (@fromDate IS NULL OR [DocumentDate] >= @fromDate)
	AND (@toDate IS NULL OR [DocumentDate] < @toDate)

	UNION ALL
	SELECT
		V.[Id],
		V.[DocumentId],
		CONVERT(NVARCHAR (255), V.[DocumentDate], 102) AS DocumentDate,
		V.[SerialNumber],
		V.[TransactionType],
		V.[IsSystem],
		V.[Direction],
		V.[AccountId],
		V.[IFRSAccountId],
		V.[IFRSNoteId],
		V.[ResponsibilityCenterId],
		-- [OperationId],
		-- [ProductCategoryId],
		-- [GeographicRegionId],
		-- [CustomerSegmentId],
		-- [TaxSegmentId],
		V.[AgentAccountId],
		V.[ResourceId],
		V.[Quantity],
		V.[MoneyAmount],
		V.[Mass],
		V.[Mass] * MU.[BaseAmount] / MU.[UnitAmount] As NormalizedMass,
		V.[Volume], 
		V.[Volume] * VU.[BaseAmount] / VU.[UnitAmount] As NormalizedVolume,
		V.[Count],
		V.[Volume] * CU.[BaseAmount] / CU.[UnitAmount] As NormalizedCount,
		V.[Time],
		V.[Value],
		V.[ExpectedSettlingDate],
		V.[Reference],
		V.[Memo],
		COALESCE(RR.[Reference], V.[RelatedReference]) AS [RelatedReference],
		V.[RelatedResourceId],
		V.[RelatedAgentAccountId],
		V.[RelatedResponsibilityCenterId],
		V.[RelatedQuantity],
		V.[RelatedMoneyAmount],
		V.[RelatedMass],
		V.[RelatedVolume],
		V.[RelatedCount],
		V.[RelatedTime],
		V.[RelatedValue]
	FROM dbo.[TransactionEntriesView] V
	CROSS JOIN IntegerList IL
	LEFT JOIN dbo.Resources R ON V.ResourceId = R.Id
	LEFT JOIN dbo.MeasurementUnits MU ON R.MassUnitId = MU.Id
	LEFT JOIN dbo.MeasurementUnits VU ON R.VolumeUnitId = VU.Id
	LEFT JOIN dbo.MeasurementUnits CU ON R.CountUnitId = CU.Id
	LEFT JOIN dbo.Resources RR ON V.RelatedResourceId = RR.Id
	WHERE V.[Frequency]		= N'Daily'
	AND (@fromDate IS NULL OR [DocumentDate] >= @fromDate)
	AND (@toDate IS NULL OR DATEADD(DAY, IL.I, [DocumentDate]) < @toDate)
	AND ([EndDate] IS NULL OR DATEADD(DAY, IL.I, [DocumentDate]) < [EndDate])

	UNION ALL
	SELECT 
		V.[Id],
		V.[DocumentId],
		CONVERT(NVARCHAR (255), V.[DocumentDate], 102) AS DocumentDate,
		V.[SerialNumber],
		V.[TransactionType],
		V.[IsSystem],
		V.[Direction],
		V.[AccountId],
		V.[IFRSAccountId],
		V.[IFRSNoteId],
		V.[ResponsibilityCenterId],
		-- [OperationId],
		-- [ProductCategoryId],
		-- [GeographicRegionId],
		-- [CustomerSegmentId],
		-- [TaxSegmentId],
		V.[AgentAccountId],
		V.[ResourceId],
		V.[Quantity],
		V.[MoneyAmount],
		V.[Mass],
		V.[Mass] * MU.[BaseAmount] / MU.[UnitAmount] As NormalizedMass,
		V.[Volume], 
		V.[Volume] * VU.[BaseAmount] / VU.[UnitAmount] As NormalizedVolume,
		V.[Count],
		V.[Volume] * CU.[BaseAmount] / CU.[UnitAmount] As NormalizedCount,
		V.[Time],
		V.[Value],
		V.[ExpectedSettlingDate],
		V.[Reference],
		V.[Memo],
		COALESCE(RR.[Reference], V.[RelatedReference]) AS [RelatedReference],
		V.[RelatedResourceId],
		V.[RelatedAgentAccountId],
		V.[RelatedResponsibilityCenterId],
		V.[RelatedQuantity],
		V.[RelatedMoneyAmount],
		V.[RelatedMass],
		V.[RelatedVolume],
		V.[RelatedCount],
		V.[RelatedTime],
		V.[RelatedValue]
	FROM dbo.[TransactionEntriesView] V
	CROSS JOIN IntegerList IL
	LEFT JOIN dbo.Resources R ON V.ResourceId = R.Id
	LEFT JOIN dbo.MeasurementUnits MU ON R.MassUnitId = MU.Id
	LEFT JOIN dbo.MeasurementUnits VU ON R.VolumeUnitId = VU.Id
	LEFT JOIN dbo.MeasurementUnits CU ON R.CountUnitId = CU.Id
	LEFT JOIN dbo.Resources RR ON V.RelatedResourceId = RR.Id
	WHERE V.[Frequency]		= N'Weekly'
	AND (@fromDate IS NULL OR [DocumentDate] >= @fromDate)
	AND (@toDate IS NULL OR DATEADD(WEEK, IL.I, [DocumentDate]) < @toDate)
	AND ([EndDate] IS NULL OR DATEADD(WEEK, IL.I, [DocumentDate]) < [EndDate])

	UNION ALL
	SELECT 
		V.[Id],
		V.[DocumentId],
		CONVERT(NVARCHAR (255), V.[DocumentDate], 102) AS DocumentDate,
		V.[SerialNumber],
		V.[TransactionType],
		V.[IsSystem],
		V.[Direction],
		V.[AccountId],
		V.[IFRSAccountId],
		V.[IFRSNoteId],
		V.[ResponsibilityCenterId],
		-- [OperationId],
		-- [ProductCategoryId],
		-- [GeographicRegionId],
		-- [CustomerSegmentId],
		-- [TaxSegmentId],
		V.[AgentAccountId],
		V.[ResourceId],
		V.[Quantity],
		V.[MoneyAmount],
		V.[Mass],
		V.[Mass] * MU.[BaseAmount] / MU.[UnitAmount] As NormalizedMass,
		V.[Volume], 
		V.[Volume] * VU.[BaseAmount] / VU.[UnitAmount] As NormalizedVolume,
		V.[Count],
		V.[Volume] * CU.[BaseAmount] / CU.[UnitAmount] As NormalizedCount,
		V.[Time],
		V.[Value],
		V.[ExpectedSettlingDate],
		V.[Reference],
		V.[Memo],
		COALESCE(RR.[Reference], V.[RelatedReference]) AS [RelatedReference],
		V.[RelatedResourceId],
		V.[RelatedAgentAccountId],
		V.[RelatedResponsibilityCenterId],
		V.[RelatedQuantity],
		V.[RelatedMoneyAmount],
		V.[RelatedMass],
		V.[RelatedVolume],
		V.[RelatedCount],
		V.[RelatedTime],
		V.[RelatedValue]
	FROM dbo.[TransactionEntriesView] V
	CROSS JOIN IntegerList IL
	LEFT JOIN dbo.Resources R ON V.ResourceId = R.Id
	LEFT JOIN dbo.MeasurementUnits MU ON R.MassUnitId = MU.Id
	LEFT JOIN dbo.MeasurementUnits VU ON R.VolumeUnitId = VU.Id
	LEFT JOIN dbo.MeasurementUnits CU ON R.CountUnitId = CU.Id
	LEFT JOIN dbo.Resources RR ON V.RelatedResourceId = RR.Id
	WHERE V.[Frequency]		= N'Monthly'
	AND (@fromDate IS NULL OR [DocumentDate] >= @fromDate)
	AND (@toDate IS NULL OR DATEADD(MONTH, IL.I, [DocumentDate]) < @toDate)
	AND ([EndDate] IS NULL OR DATEADD(MONTH, IL.I, [DocumentDate]) < [EndDate])
	
	UNION ALL
	SELECT
		V.[Id],
		V.[DocumentId],
		CONVERT(NVARCHAR (255), V.[DocumentDate], 102) AS DocumentDate,
		V.[SerialNumber],
		V.[TransactionType],
		V.[IsSystem],
		V.[Direction],
		V.[AccountId],
		V.[IFRSAccountId],
		V.[IFRSNoteId],
		V.[ResponsibilityCenterId],
		-- [OperationId],
		-- [ProductCategoryId],
		-- [GeographicRegionId],
		-- [CustomerSegmentId],
		-- [TaxSegmentId],
		V.[AgentAccountId],
		V.[ResourceId],
		V.[Quantity],
		V.[MoneyAmount],
		V.[Mass],
		V.[Mass] * MU.[BaseAmount] / MU.[UnitAmount] As NormalizedMass,
		V.[Volume], 
		V.[Volume] * VU.[BaseAmount] / VU.[UnitAmount] As NormalizedVolume,
		V.[Count],
		V.[Volume] * CU.[BaseAmount] / CU.[UnitAmount] As NormalizedCount,
		V.[Time],
		V.[Value],
		V.[ExpectedSettlingDate],
		V.[Reference],
		V.[Memo],
		COALESCE(RR.[Reference], V.[RelatedReference]) AS [RelatedReference],
		V.[RelatedResourceId],
		V.[RelatedAgentAccountId],
		V.[RelatedResponsibilityCenterId],
		V.[RelatedQuantity],
		V.[RelatedMoneyAmount],
		V.[RelatedMass],
		V.[RelatedVolume],
		V.[RelatedCount],
		V.[RelatedTime],
		V.[RelatedValue]
	FROM dbo.[TransactionEntriesView] V
	CROSS JOIN IntegerList IL
	LEFT JOIN dbo.Resources R ON V.ResourceId = R.Id
	LEFT JOIN dbo.MeasurementUnits MU ON R.MassUnitId = MU.Id
	LEFT JOIN dbo.MeasurementUnits VU ON R.VolumeUnitId = VU.Id
	LEFT JOIN dbo.MeasurementUnits CU ON R.CountUnitId = CU.Id
	LEFT JOIN dbo.Resources RR ON V.RelatedResourceId = RR.Id
	WHERE V.[Frequency]		= N'Quarterly'
	AND (@fromDate IS NULL OR [DocumentDate] >= @fromDate)
	AND (@toDate IS NULL OR DATEADD(QUARTER, IL.I, [DocumentDate]) < @toDate)
	AND ([EndDate] IS NULL OR DATEADD(QUARTER, IL.I, [DocumentDate]) < [EndDate])

	UNION ALL
	SELECT 
		V.[Id],
		V.[DocumentId],
		CONVERT(NVARCHAR (255), V.[DocumentDate], 102) AS DocumentDate,
		V.[SerialNumber],
		V.[TransactionType],
		V.[IsSystem],
		V.[Direction],
		V.[AccountId],
		V.[IFRSAccountId],
		V.[IFRSNoteId],
		V.[ResponsibilityCenterId],
		-- [OperationId],
		-- [ProductCategoryId],
		-- [GeographicRegionId],
		-- [CustomerSegmentId],
		-- [TaxSegmentId],
		V.[AgentAccountId],
		V.[ResourceId],
		V.[Quantity],
		V.[MoneyAmount],
		V.[Mass],
		V.[Mass] * MU.[BaseAmount] / MU.[UnitAmount] As NormalizedMass,
		V.[Volume], 
		V.[Volume] * VU.[BaseAmount] / VU.[UnitAmount] As NormalizedVolume,
		V.[Count],
		V.[Volume] * CU.[BaseAmount] / CU.[UnitAmount] As NormalizedCount,
		V.[Time],
		V.[Value],
		V.[ExpectedSettlingDate],
		V.[Reference],
		V.[Memo],
		COALESCE(RR.[Reference], V.[RelatedReference]) AS [RelatedReference],
		V.[RelatedResourceId],
		V.[RelatedAgentAccountId],
		V.[RelatedResponsibilityCenterId],
		V.[RelatedQuantity],
		V.[RelatedMoneyAmount],
		V.[RelatedMass],
		V.[RelatedVolume],
		V.[RelatedCount],
		V.[RelatedTime],
		V.[RelatedValue]
	FROM dbo.[TransactionEntriesView] V
	CROSS JOIN IntegerList IL
	LEFT JOIN dbo.Resources R ON V.ResourceId = R.Id
	LEFT JOIN dbo.MeasurementUnits MU ON R.MassUnitId = MU.Id
	LEFT JOIN dbo.MeasurementUnits VU ON R.VolumeUnitId = VU.Id
	LEFT JOIN dbo.MeasurementUnits CU ON R.CountUnitId = CU.Id
	LEFT JOIN dbo.Resources RR ON V.RelatedResourceId = RR.Id
	WHERE V.[Frequency]		= N'Yearly'
	AND (@fromDate IS NULL OR [DocumentDate] >= @fromDate)
	AND (@toDate IS NULL OR DATEADD(YEAR, IL.I, [DocumentDate]) < @toDate)
	AND ([EndDate] IS NULL OR DATEADD(YEAR, IL.I, [DocumentDate]) < [EndDate])
;