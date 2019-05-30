﻿EXEC sp_set_session_context 'Tenantid', 106;
DECLARE @TenantId int = CONVERT(INT, SESSION_CONTEXT(N'TenantId'));
DECLARE @Now DATETIMEOFFSET(7) = SYSDATETIMEOFFSET();
DECLARE @UserId int;
IF NOT EXISTS(SELECT * FROM [dbo].[LocalUsers])
BEGIN
	INSERT INTO [dbo].[LocalUsers]([Name], [AgentId]) VALUES
	(N'Dr. Akra', NULL); -- N'DESKTOP-V0VNDC4\Mohamad Akra'
		SET @UserId = SCOPE_IDENTITY();
END
ELSE
SELECT @UserId = [Id] FROM dbo.LocalUsers WHERE [Name] = N'Dr. Akra';
EXEC sp_set_session_context 'UserId', @UserId;
SET @UserId = CONVERT(INT, SESSION_CONTEXT(N'UserId'));

:r .\01_IFRSConcepts.sql
--:r .\08_MeasurementUnits.sql -- WRONG. To provision, use the code in Testing instead
--:r .\02_Accounts.sql
--:r .\03_IFRSNotes.sql
--EXEC [dbo].[adm_Accounts_Notes__Update];
--:r .\04_AccountsNotes.sql
--:r .\05_DocumentTypes.sql
--:r .\06_LineTypeSpecifications.sql
--:r .\07_AccountSpecifications.sql