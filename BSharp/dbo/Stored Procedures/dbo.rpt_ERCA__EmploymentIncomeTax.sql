﻿CREATE PROCEDURE [dbo].[rpt_ERCA__EmploymentIncomeTax]
	@fromDate Datetime = '01.01.2000', 
	@toDate Datetime = '01.01.2100'
AS
BEGIN
	SELECT
		A.TaxIdentificationNumber As [Employee TIN],
		A.[Name] As [Employee Full Name],
		J.[RelatedMoneyAmount] As [Taxable Income], 
		J.[Value] As [Tax Withheld]
	FROM [dbo].[fi_Journal](@fromDate, @toDate) J
	LEFT JOIN [dbo].[AgentAccounts] AA  ON J.[RelatedAgentAccountId] = AA.Id
	LEFT JOIN [dbo].[Agents] A ON AA.AgentId = A.Id
	WHERE J.[IfrsAccountId] = N'CurrentEmployeeIncomeTaxPayable'
	AND J.Direction = -1;
END