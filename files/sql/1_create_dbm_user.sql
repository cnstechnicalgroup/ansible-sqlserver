USE master;
GO

DECLARE @LOGINEXISTS varchar(12) = ''
DECLARE @USEREXISTS varchar(12) = ''

-- create login if it doesn't exist
If NOT EXISTS (SELECT loginname FROM master.dbo.syslogins WHERE name = 'dbm_login')
BEGIN

	CREATE LOGIN dbm_login WITH PASSWORD = 'TESTpasswordm837y2';

END


-- create user if it doesn't exist
IF NOT EXISTS (SELECT name	FROM sys.database_principals WHERE name = 'dbm_user')
BEGIN		
	CREATE USER dbm_user FOR LOGIN dbm_login;
END

-- ensure that login and user exist
SET NOCOUNT ON
SELECT @LOGINEXISTS = 'login exists' FROM master.dbo.syslogins WHERE name = 'dbm_login'
SELECT @USEREXISTS = 'user exists'	FROM sys.database_principals WHERE name = 'dbm_user'
SELECT @LOGINEXISTS
SELECT @USEREXISTS
SET NOCOUNT OFF
