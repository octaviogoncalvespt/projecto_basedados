-- Write your own SQL object definition here, and it'll be included in your package.
CREATE DATABASE FinalProject02;
GO

USE FinalProject02;
GO

-- CREATED
CREATE TABLE OrgUnits
(
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Cliente VARCHAR(100) NOT NULL,
    Departamento VARCHAR(25) NOT NULL,
    Email VARCHAR(50) NULL,
    Telf VARCHAR(20) NULL
);

-- CREATED
CREATE TABLE Users
(
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Username VARCHAR(50) NOT NULL UNIQUE,
    Email VARCHAR(150) NOT NULL,
    Telf VARCHAR(50) NULL,
    OrgUnitID INT NOT NULL,
    CONSTRAINT FK_Users_OrgUnits
        FOREIGN KEY (OrgUnitID) REFERENCES OrgUnits(ID)
);

-- CREATED
CREATE TABLE Techs
(
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Username VARCHAR(50) NOT NULL UNIQUE,
    Email VARCHAR(150) NOT NULL,
    Telf VARCHAR(50) NULL
);

-- CREATED
CREATE TABLE TicketCat
(
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Descricao VARCHAR(100) NOT NULL
);

-- CREATED
CREATE TABLE TicketPriority
(
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Descricao VARCHAR(100) NOT NULL
);

-- CREATED
CREATE TABLE TicketEstados
(
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Descricao VARCHAR(50) NOT NULL
);

CREATE TABLE SLAs
(
    ID INT IDENTITY(1,1) PRIMARY KEY,
    TicketCatID INT NOT NULL,
    TicketPriorityID INT NOT NULL,
    TempoMaxPrimeiraRespostaMin INT NOT NULL,
    TempoMaxResolucaoMin INT NOT NULL,
    CONSTRAINT FK_SLAs_TicketCat
        FOREIGN KEY (TicketCatID) REFERENCES TicketCat(ID),
    CONSTRAINT FK_SLAs_TicketPriority
        FOREIGN KEY (TicketPriorityID) REFERENCES TicketPriority(ID),
    CONSTRAINT UQ_SLAs_Cat_Priority
        UNIQUE (TicketCatID, TicketPriorityID)
);

CREATE TABLE Tickets
(
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Assunto VARCHAR(200) NOT NULL,
    Descricao VARCHAR(MAX) NULL,
    DataAbertura DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
    DataFecho DATETIME2 NULL,
    UserID INT NOT NULL,
    TechID INT NULL,
    TicketCatID INT NOT NULL,
    TicketPriorityID INT NOT NULL,
    SlaID INT NULL,
    EstadoAtualID INT NOT NULL,
    CONSTRAINT FK_Tickets_Users
        FOREIGN KEY (UserID) REFERENCES Users(ID),
    CONSTRAINT FK_Tickets_Techs
        FOREIGN KEY (TechID) REFERENCES Techs(ID),
    CONSTRAINT FK_Tickets_TicketCat
        FOREIGN KEY (TicketCatID) REFERENCES TicketCat(ID),
    CONSTRAINT FK_Tickets_TicketPriority
        FOREIGN KEY (TicketPriorityID) REFERENCES TicketPriority(ID),
    CONSTRAINT FK_Tickets_SLAs
        FOREIGN KEY (SlaID) REFERENCES SLAs(ID),
    CONSTRAINT FK_Tickets_EstadoAtual
        FOREIGN KEY (EstadoAtualID) REFERENCES TicketEstados(ID),
    CONSTRAINT CK_Tickets_Tecnico_Aberto
        CHECK (EstadoAtualID = 1 OR TechID IS NOT NULL)
);

CREATE TABLE TicketEstadoHistorico
(
    ID INT IDENTITY(1,1) PRIMARY KEY,
    TicketID INT NOT NULL,
    EstadoID INT NOT NULL,
    DataAlteracao DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
    UserID INT NULL,
    TechID INT NULL,
    Observacao VARCHAR(MAX) NULL,
    CONSTRAINT FK_TicketEstadoHistorico_Tickets
        FOREIGN KEY (TicketID) REFERENCES Tickets(ID),
    CONSTRAINT FK_TicketEstadoHistorico_Estados
        FOREIGN KEY (EstadoID) REFERENCES TicketEstados(ID),
    CONSTRAINT FK_TicketEstadoHistorico_Users
        FOREIGN KEY (UserID) REFERENCES Users(ID),
    CONSTRAINT FK_TicketEstadoHistorico_Techs
        FOREIGN KEY (TechID) REFERENCES Techs(ID)
);

CREATE TABLE TicketIntervencao
(
    ID INT IDENTITY(1,1) PRIMARY KEY,
    TicketID INT NOT NULL,
    TechID INT NULL,
    DataHora DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
    Descricao VARCHAR(200) NOT NULL,
    Notas VARCHAR(MAX) NULL,
    Tempo INT NOT NULL,
    CONSTRAINT FK_TicketIntervencao_Tickets
        FOREIGN KEY (TicketID) REFERENCES Tickets(ID),
    CONSTRAINT FK_TicketIntervencao_Techs
        FOREIGN KEY (TechID) REFERENCES Techs(ID)
);