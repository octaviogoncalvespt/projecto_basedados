-- create Projeto database
use master;

CREATE DATABASE Projecto;

GO

USE Projecto;

-- create fundamental tables
CREATE TABLE OrgUnits

(
    ID           INT IDENTITY (1,1) PRIMARY KEY,
    Cliente      VARCHAR(100) NOT NULL,
    Departamento VARCHAR(25)  NOT NULL,
    Email        VARCHAR(50)  NULL,
    Telf         VARCHAR(20)  NULL
);

CREATE TABLE Techs
(
    ID       INT IDENTITY (1,1) PRIMARY KEY,
    Nome     VARCHAR(100) NOT NULL,
    Username VARCHAR(25)  NOT NULL UNIQUE,
    Email    VARCHAR(150) NOT NULL,
    Telf     VARCHAR(50)  NULL
);

CREATE TABLE TicketCat
(
    ID        INT IDENTITY (1,1) PRIMARY KEY,
    Descricao VARCHAR(100) NOT NULL
);

CREATE TABLE TicketPriority
(
    ID        INT IDENTITY (1,1) PRIMARY KEY,
    Descricao VARCHAR(100) NOT NULL
);

CREATE TABLE TicketEstados
(
    ID        INT IDENTITY (1,1) PRIMARY KEY,
    Descricao VARCHAR(50) NOT NULL
);


-- create dependent tables
CREATE TABLE Users
(
    ID        INT IDENTITY (1,1) PRIMARY KEY,
    Nome      VARCHAR(100) NOT NULL,
    Username  VARCHAR(50)  NOT NULL UNIQUE,
    Email     VARCHAR(150) NOT NULL,
    Telf      VARCHAR(50)  NULL,
    OrgUnitID INT          NOT NULL,
    CONSTRAINT FK_Users_OrgUnits
        FOREIGN KEY (OrgUnitID) REFERENCES OrgUnits (ID)
);

CREATE TABLE SLA
(
    ID                          INT IDENTITY (1,1) PRIMARY KEY,
    TicketCatID                 INT NOT NULL,
    TicketPriorityID            INT NOT NULL,
    TempoMaxPrimeiraRespostaMin INT NOT NULL,
    TempoMaxResolucao           INT NOT NULL,
    CONSTRAINT FK_SLA_TicketCat
        FOREIGN KEY (TicketCatID) REFERENCES TicketCat (ID),
    CONSTRAINT FK_SLA_TicketPriority
        FOREIGN KEY (TicketPriorityID) REFERENCES TicketPriority (ID),
    CONSTRAINT UQ_SLA_Cat_Priority
        UNIQUE (TicketCatID, TicketPriorityID)
);

CREATE TABLE Tickets
(
    ID               INT IDENTITY (1,1) PRIMARY KEY,
    Assunto          VARCHAR(200) NOT NULL,
    Descricao        VARCHAR(MAX) NULL,
    DataAbertura     DATETIME2    NOT NULL DEFAULT SYSUTCDATETIME(),
    DataFecho        DATETIME2    NULL,
    UserID           INT          NOT NULL,
    TechID           INT          NULL,
    TicketCatID      INT          NOT NULL,
    TicketPriorityID INT          NOT NULL,
    SlaID            INT          NULL,
    EstadoAtualID    INT          NOT NULL,
    CONSTRAINT FK_Tickets_Users
        FOREIGN KEY (UserID) REFERENCES Users (ID),
    CONSTRAINT FK_Tickets_Techs
        FOREIGN KEY (TechID) REFERENCES Techs (ID),
    CONSTRAINT FK_Tickets_TicketCat
        FOREIGN KEY (TicketCatID) REFERENCES TicketCat (ID),
    CONSTRAINT FK_Tickets_TicketPriority
        FOREIGN KEY (TicketPriorityID) REFERENCES TicketPriority (ID),
    CONSTRAINT FK_Tickets_SLA
        FOREIGN KEY (SlaID) REFERENCES SLA (ID),
    CONSTRAINT FK_Tickets_EstadoAtual
        FOREIGN KEY (EstadoAtualID) REFERENCES TicketEstados (ID),
        -- New or must be assigned to tech
    CONSTRAINT CK_Tickets_Tecnico_Aberto
        CHECK (EstadoAtualID = 1 OR TechID IS NOT NULL),
        -- Resolved/Closed must have DataFecho NOT NULL
    CONSTRAINT CK_Tickets_DataFecho_Quando_Fechado
        CHECK (EstadoAtualID NOT IN (4, 5) OR DataFecho IS NOT NULL)
);

CREATE TABLE TicketEstadoHistorico
(
    ID            INT IDENTITY (1,1) PRIMARY KEY,
    TicketID      INT          NOT NULL,
    EstadoID      INT          NOT NULL,
    DataAlteracao DATETIME2    NOT NULL DEFAULT SYSUTCDATETIME(),
    UserID        INT          NULL,
    TechID        INT          NULL,
    Observacao    VARCHAR(MAX) NULL,
    CONSTRAINT FK_TicketEstadoHistorico_Tickets
        FOREIGN KEY (TicketID) REFERENCES Tickets (ID),
    CONSTRAINT FK_TicketEstadoHistorico_Estados
        FOREIGN KEY (EstadoID) REFERENCES TicketEstados (ID),
    CONSTRAINT FK_TicketEstadoHistorico_Users
        FOREIGN KEY (UserID) REFERENCES Users (ID),
    CONSTRAINT FK_TicketEstadoHistorico_Techs
        FOREIGN KEY (TechID) REFERENCES Techs (ID)
);

CREATE TABLE TicketIntervencao
(
    ID        INT IDENTITY (1,1) PRIMARY KEY,
    TicketID  INT          NOT NULL,
    TechID    INT          NULL,
    DataHora  DATETIME2    NOT NULL DEFAULT SYSUTCDATETIME(),
    Descricao VARCHAR(200) NOT NULL,
    Notas     VARCHAR(MAX) NULL,
    Tempo     INT          NOT NULL,
    CONSTRAINT FK_TicketIntervencao_Tickets
        FOREIGN KEY (TicketID) REFERENCES Tickets (ID),
    CONSTRAINT FK_TicketIntervencao_Techs
        FOREIGN KEY (TechID) REFERENCES Techs (ID)
);


GO
-- trigger to auto-set DataFecho when state becomes Resolved (4) or Closed (5)
CREATE TRIGGER TR_Tickets_SetDataFecho_OnResolvedClosed
    ON Tickets
    AFTER UPDATE
    AS
BEGIN
    UPDATE t
    SET DataFecho = SYSUTCDATETIME()
    FROM Tickets t
             JOIN inserted i ON t.ID = i.ID
             JOIN deleted d ON d.ID = i.ID
    WHERE i.EstadoAtualID IN (4, 5)     -- new state: Resolved/Closed
      AND d.EstadoAtualID NOT IN (4, 5) -- previous state: not Resolved/Closed
      AND t.DataFecho IS NULL; -- only if still null
END;

GO

-- Trigger to checkk if Cat + Prio = Sla
CREATE TRIGGER TR_Tickets_ValidateSLA 
ON Tickets 
AFTER INSERT, UPDATE 
AS 
BEGIN
    SET NOCOUNT ON;
    IF EXISTS ( 
    SELECT 1
    FROM inserted i
        JOIN SLA s ON i.SlaID = s.ID
    WHERE i.TicketCatID <> s.TicketCatID
        OR i.TicketPriorityID <> s.TicketPriorityID
     ) 
     BEGIN
        RAISERROR('SlaID não corresponde à categoria e prioridade do ticket.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END
END;
      GO

