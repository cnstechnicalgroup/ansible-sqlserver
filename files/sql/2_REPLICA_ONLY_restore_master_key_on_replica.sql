
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'TESTpasswordm837y2';
CREATE CERTIFICATE dbm_certificate   
    AUTHORIZATION dbm_user
    FROM FILE = '/var/opt/mssql/data/dbm_certificate.cer'
    WITH PRIVATE KEY (
    FILE = '/var/opt/mssql/data/dbm_certificate.pvk',
    DECRYPTION BY PASSWORD = 'TESTpasswordm837y2'
            );
