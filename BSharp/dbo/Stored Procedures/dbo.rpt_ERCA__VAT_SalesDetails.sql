﻿CREATE PROCEDURE [dbo].[rpt_ERCA__VAT_SalesDetails] -- used for online submission
	@fromDate Datetime = '01.01.2000', 
	@toDate Datetime = '01.01.2100'
AS
SELECT
	J.Id, A.TaxIdentificationNumber AS TIN, J.AdditionalReference AS MRC,
	J.ExternalReference AS RCPT_NUM, J.DocumentDate As RCPT_Date,  J.Quantity,
	J.RelatedMoneyAmount As Price, N'' AS COM_CODE, ResourceType As COM_DETAIL,
	R.[Name] As [Description]
FROM dbo.fi_Journal(@fromDate, @toDate) J
LEFT JOIN dbo.Resources R ON J.RelatedResourceId = R.Id 
LEFT JOIN dbo.Agents A ON J.RelatedAgentId = A.Id
WHERE IfrsAccountId = N'CurrentValueAddedTaxPayables'
GO;