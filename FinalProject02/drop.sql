-- Mudar para master para poder apagar a database
USE master;
GO

-- Colocar a database em modo single_user para garantir que não está em uso
ALTER DATABASE Projecto SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO

-- Apagar a database
DROP DATABASE IF EXISTS Projecto;
GO
