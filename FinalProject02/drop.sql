--------
Drop all tables
--------

USE FinalProject02;
GO

-- Tabelas com referencias externas
DROP TABLE IF EXISTS TicketIntervencao;
DROP TABLE IF EXISTS TicketEstadoHistorico;
DROP TABLE IF EXISTS Tickets;
DROP TABLE IF EXISTS SLAs;

-- Tabelas de origem
DROP TABLE IF EXISTS TicketEstados;
DROP TABLE IF EXISTS TicketPriority;
DROP TABLE IF EXISTS TicketCat;
DROP TABLE IF EXISTS Techs;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS OrgUnits;
GO

USE master
GO

DROP DATABASE IF EXISTS FinalProject02;
GO