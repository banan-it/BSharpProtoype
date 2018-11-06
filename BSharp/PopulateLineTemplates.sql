﻿INSERT [dbo].[TransactionTemplates] ([TransactionType], [EntryNumber], [Definition], [Operation], [Account], [Custody], [Resource], [Direction], [Amount], [Value], [Note], [RelatedReference], [RelatedAgent], [RelatedResource], [RelatedAmount], [RelatedUDLMember]) VALUES
	(N'CashIssueToSupplier', 1, N'Calculation', NULL, N'''CurrentPayablesToTradeSuppliers''', NULL, N'dbo.fn_FunctionalCurrency()', N'1', NULL, N'dbo.Amount(1,@Entries)', NULL, NULL, NULL, NULL, NULL, NULL),
	(N'CashIssueToSupplier', 1, N'Label', NULL, NULL, N'Supplier', N'Currency', NULL, N'Amount', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(N'CashIssueToSupplier', 1, N'Validation', NULL, N'''PurchaseContracts''', NULL, NULL, N'1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(N'CashIssueToSupplier', 2, N'Calculation', NULL, N'''CashOnHand''', NULL, N'dbo.fn_FunctionalCurrency()', N'-1', N'dbo.Amount(1,@Entries)', N'dbo.Amount(2,@Entries)', N'''PaymentsToSuppliersForGoodsAndServices''', NULL, NULL, NULL, NULL, NULL),
	(N'CashIssueToSupplier', 2, N'Label', NULL, NULL, N'Cash Custody', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(N'CashIssueToSupplier', 2, N'Validation', NULL, N'''CashOnHand''', NULL, NULL, N'-1', NULL, NULL, N'''PaymentsToSuppliersForGoodsAndServices''', NULL, NULL, NULL, NULL, NULL),
	(N'CashReceiptFromCustomer', 1, N'Calculation', NULL, N'''CashOnHand''', NULL, N'dbo.fn_FunctionalCurrency()', N'1', NULL, N'dbo.Amount(1,@Entries)', N'''ReceiptsFromSalesOfGoodsAndRenderinfServices''', NULL, NULL, NULL, NULL, NULL),
	(N'CashReceiptFromCustomer', 1, N'Label', NULL, NULL, N'Cash Custody', NULL, NULL, N'Payment', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(N'CashReceiptFromCustomer', 2, N'Calculation', NULL, N'''SalesContracts''', NULL, N'dbo.fn_FunctionalCurrency()', N'-1', N'dbo.Amount(1,@Entries)', N'dbo.Amount(2,@Entries)', NULL, NULL, NULL, NULL, NULL, NULL),
	(N'CashReceiptFromCustomer', 2, N'Label', NULL, NULL, N'Customer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(N'EmployeeIncomeTax', 1, N'Calculation', NULL, N'''EmploymentContracts''', NULL, N'dbo.fn_FunctionalCurrency()', N'1', NULL, N'dbo.Amount(1,@Entries)', NULL, NULL, NULL, NULL, NULL, NULL),
	(N'EmployeeIncomeTax', 1, N'Label', NULL, NULL, N'Employee', N'Currency', NULL, N'Income Tax', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(N'EmployeeIncomeTax', 1, N'Validation', NULL, N'''CurrentPayablesToEmployees''', NULL, NULL, N'1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(N'EmployeeIncomeTax', 2, N'Calculation', NULL, N'''CurrentEmployeeIncomeTaxPayable''', N'dbo.fn_Settings(''TaxAuthority'')', N'dbo.fn_FunctionalCurrency()', N'-1', N'dbo.Amount(1,@Entries)', N'dbo.Amount(2,@Entries)', NULL, NULL, N'dbo.Custody(1,@Entries)', NULL, NULL, NULL),
	(N'EmployeeIncomeTax', 2, N'Label', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(N'EmployeeIncomeTax', 2, N'Validation', NULL, N'''CurrentEmployeeIncomeTaxPayable''', NULL, NULL, N'-1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(N'Labor', 1, N'Calculation', NULL, N'''ShorttermEmployeeBenefitsAccruals''', NULL, N'dbo.fn_Settings(''Labor'')', N'1', N'208', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(N'Labor', 1, N'Label', NULL, NULL, NULL, N'Employee', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(N'Labor', 1, N'Validation', NULL, N'''EmploymentContracts''', NULL, NULL, N'1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(N'Labor', 2, N'Calculation', NULL, N'''EmploymentContracts''', N'dbo.Custody(1,@Entries)', N'dbo.fn_FunctionalCurrency()', N'-1', NULL, N'dbo.Amount(2,@Entries)', NULL, N'''Basic''', NULL, NULL, NULL, NULL),
	(N'Labor', 2, N'Label', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(N'Labor', 2, N'Validation', NULL, N'''EmploymentContracts''', NULL, NULL, N'-1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(N'Labor', 3, N'Calculation', NULL, N'''EmploymentContracts''', N'dbo.Custody(1,@Entries)', N'dbo.fn_FunctionalCurrency()', N'-1', NULL, N'dbo.Amount(3,@Entries)', NULL, N'''Transportation''', NULL, NULL, NULL, NULL),
	(N'LaborReceiptFromEmployee', 1, N'Calculation', NULL, N'''AdministrativeExpense''', NULL, N'dbo.fn_Settings(''Labor'')', N'1', NULL, NULL, N'''WagesAndSalaries''', NULL, NULL, NULL, NULL, NULL),
	(N'LaborReceiptFromEmployee', 1, N'Label', NULL, NULL, N'Employee', N'Salary Component', NULL, N'Quantity', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(N'LaborReceiptFromEmployee', 1, N'Validation', NULL, N'''AdministrativeExpense''', N'0', NULL, N'1', NULL, NULL, N'''WagesAndSalaries''', NULL, NULL, NULL, NULL, NULL),
	(N'LaborReceiptFromEmployee', 2, N'Calculation', NULL, N'''EmploymentContracts''', NULL, N'dbo.Resource(1, @Entries)', N'-1', N'dbo.Amount(1,@Entries)', N'@Bulk:@AccountId = N''EmploymentContracts'', @Direction = 1;', NULL, NULL, NULL, NULL, NULL, NULL),
	(N'LaborReceiptFromEmployee', 2, N'Label', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(N'LaborReceiptFromEmployee', 2, N'Validation', NULL, N'''EmploymentContracts''', NULL, NULL, N'-1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(N'Purchase', 1, N'Calculation', NULL, N'''GoodsAndServicesReceivedFromSupplierButNotBilled''', NULL, NULL, N'1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(N'Purchase', 1, N'Label', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(N'Purchase', 1, N'Validation', NULL, N'''CurrentValueAddedTaxReceivables''', N'dbo.fn_Settings(''TaxAuthority'')', NULL, N'1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(N'Purchase', 2, N'Calculation', NULL, N'''CurrentValueAddedTaxReceivables''', N'dbo.fn_Settings(''TaxAuthority'')', N'dbo.fn_FunctionalCurrency()', N'1', NULL, N'dbo.Amount(2,@Entries)', NULL, NULL, N'dbo.Custody(1,@Entries)', N'dbo.Resource(1, @Entries)', N'dbo.Value(1,@Entries)', NULL),
	(N'Purchase', 2, N'Label', NULL, NULL, NULL, N'Supplier', NULL, N'VAT', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(N'Purchase', 2, N'Validation', NULL, N'''PurchasesVAT''', NULL, NULL, N'-1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(N'Purchase', 3, N'Calculation', NULL, N'''CurrentPayablesToTradeSuppliers''', N'dbo.Custody(1,@Entries)', N'dbo.fn_FunctionalCurrency()', N'-1', N'dbo.Amount(2, @Entries)+dbo.RelatedAmount(2, @Entries)', N'dbo.Amount(3,@Entries)', NULL, NULL, NULL, NULL, NULL, NULL),
	(N'PurchaseWitholdingTax', 1, N'Calculation', NULL, N'''CurrentPayablesToTradeSuppliers''', NULL, N'dbo.fn_FunctionalCurrency()', N'1', NULL, N'dbo.Amount(1,@Entries)', NULL, NULL, NULL, NULL, NULL, NULL),
	(N'PurchaseWitholdingTax', 1, N'Label', NULL, NULL, NULL, N'Supplier', NULL, N'Tax Withtheld', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(N'PurchaseWitholdingTax', 1, N'Validation', NULL, N'''PurchaseContracts''', NULL, NULL, N'1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(N'PurchaseWitholdingTax', 2, N'Calculation', NULL, N'''CurrentWithholdingTaxPayable''', N'dbo.fn_Settings(''TaxAuthority'')', N'dbo.fn_FunctionalCurrency()', N'-1', N'dbo.Amount(1,@Entries)', N'dbo.Amount(2,@Entries)', NULL, NULL, N'dbo.Custody(1,@Entries)', NULL, NULL, NULL),
	(N'PurchaseWitholdingTax', 2, N'Label', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(N'PurchaseWitholdingTax', 2, N'Validation', NULL, N'''CurrentWithholdingTaxPayable''', N'dbo.fn_Settings(''TaxAuthority'')', NULL, N'-1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(N'Sale', 1, N'Calculation', NULL, N'''GoodsAndServicesDeliveredToCustomerButNotBilled''', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(N'StockReceiptFromSupplier', 1, N'Calculation', NULL, N'''OtherInventories''', NULL, NULL, N'1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(N'StockReceiptFromSupplier', 1, N'Label', NULL, NULL, N'Store', N'Item', NULL, N'Quantity', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(N'StockReceiptFromSupplier', 1, N'Validation', NULL, N'''OtherInventories''', NULL, NULL, N'1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(N'StockReceiptFromSupplier', 2, N'Calculation', NULL, N'''GoodsAndServicesReceivedFromSupplierButNotBilled''', NULL, N'dbo.Resource(1, @Entries)', N'-1', N'dbo.Amount(1,@Entries)', N'@Bulk:@AccountId = N''PurchaseContracts'', @Direction = 1;', NULL, NULL, NULL, NULL, NULL, NULL),
	(N'StockReceiptFromSupplier', 2, N'Label', NULL, NULL, N'Supplier', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(N'StockReceiptFromSupplier', 2, N'Validation', NULL, N'''PurchaseContracts''', NULL, NULL, N'-1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);