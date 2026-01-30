USE Projecto;
GO

-- Simple Lists --

-- All Tickets
SELECT *
FROM Tickets;

-- ALL users
SELECT *
FROM Users;

-- All Techs
SELECT *
FROM Techs;

-- Open Tickets
SELECT *
FROM Tickets
WHERE EstadoAtualID = 1;

-- Closed Tickets
SELECT *
FROM Tickets
WHERE EstadoAtualID = 5;


-- Specific Selects --


-- Tickets assigned to a specific Tech // USE ID OF TECH YOU WANT TO CHECK
SELECT *
FROM Tickets
WHERE TechID = 2;

-- All Techs who worked on a specific Ticket // USE ID OF TICKET YOU WANT TO CHECK
SELECT TicketEstadoHistorico.TicketID, TicketEstadoHistorico.EstadoID, Techs.Nome
FROM TicketEstadoHistorico
    JOIN Techs ON TicketEstadoHistorico.TechID = Techs.ID
WHERE TicketEstadoHistorico.TicketID = 4;

-- Time spend per Tech
SELECT
    te.Nome AS Tecnico,
    COUNT(DISTINCT ti.TicketID) AS TicketsComIntervencao,
    SUM(ti.Tempo)               AS MinutosTrabalhados
FROM TicketIntervencao ti
    JOIN Techs te ON te.ID = ti.TechID
GROUP BY te.Nome
ORDER BY MinutosTrabalhados DESC;

-- Users who have tickets and how many
SELECT
    Tickets.UserID,
    Users.Nome AS Name,
    COUNT(*) AS TicketCount
FROM Tickets
    JOIN Users ON Tickets.UserID = Users.ID
GROUP BY Tickets.UserID, Users.Nome;

-- High Priority Open Tickets
SELECT *
FROM Tickets t
WHERE t.EstadoAtualID BETWEEN 1 AND 3
ORDER BY t.TicketPriorityID DESC;

-- Ticket by state
SELECT
    e.Descricao AS Estado,
    COUNT(*)    AS TotalTickets
FROM Tickets t
    JOIN TicketEstados e ON e.ID = t.EstadoAtualID
GROUP BY e.Descricao
ORDER BY TotalTickets DESC;

-- Tickets closed per day
SELECT
    CAST(DataFecho AS date) AS Dia,
    COUNT(*)                AS TicketsFechados
FROM Tickets
WHERE DataFecho IS NOT NULL
GROUP BY CAST(DataFecho AS date)
ORDER BY Dia;

-- Unassiged tickets
SELECT
    t.ID,
    t.Assunto,
    u.Nome        AS Solicitante,
    c.Descricao   AS Categoria,
    p.Descricao   AS Prioridade,
    e.Descricao   AS Estado,
    t.DataAbertura
FROM Tickets t
    JOIN Users u ON u.ID = t.UserID
    JOIN TicketCat c ON c.ID = t.TicketCatID
    JOIN TicketPriority p ON p.ID = t.TicketPriorityID
    JOIN TicketEstados e ON e.ID = t.EstadoAtualID
WHERE t.TechID IS NULL
ORDER BY t.DataAbertura;

-- Tickets by category and priority
SELECT
    c.Descricao AS Categoria,
    p.Descricao AS Prioridade,
    COUNT(*)    AS TotalTickets
FROM Tickets t
    JOIN TicketCat c ON c.ID = t.TicketCatID
    JOIN TicketPriority p ON p.ID = t.TicketPriorityID
GROUP BY c.Descricao, p.Descricao
ORDER BY Categoria, Prioridade;

-- Notes for a specific ticket and the tech who did them // USE ID OF TICKET YOU WANT TO CHECK
SELECT
    Tickets.ID,
    TicketIntervencao.Descricao,
    Techs.Nome AS Nome_do_técnico,
    TicketEstados.Descricao AS Estado_atual_do_ticket
FROM Tickets
    JOIN TicketIntervencao ON Tickets.ID = TicketIntervencao.TicketID
    JOIN Techs ON TicketIntervencao.TechID = Techs.ID
    JOIN TicketEstados ON Tickets.EstadoAtualID = TicketEstados.ID
WHERE Tickets.ID = 4;

-- Number of tickets per OrgUnit (Client and Department)
SELECT
    ou.Cliente,
    ou.Departamento,
    COUNT(DISTINCT t.ID) AS Tickets
FROM OrgUnits ou
    JOIN Users u ON u.OrgUnitID = ou.ID
    JOIN Tickets t ON t.UserID = u.ID
GROUP BY ou.Cliente, ou.Departamento
ORDER BY Tickets DESC;

-- Tickets that met SLA & those that did not
SELECT
    c.Descricao AS Categoria,
    p.Descricao AS Prioridade,
    COUNT(*) AS TicketsFechados,
    SUM(CASE
            WHEN DATEDIFF(MINUTE, t.DataAbertura, t.DataFecho) <= s.TempoMaxResolucao
            THEN 1 ELSE 0 END) AS DentroSLA,
    SUM(CASE
            WHEN DATEDIFF(MINUTE, t.DataAbertura, t.DataFecho) > s.TempoMaxResolucao
            THEN 1 ELSE 0 END) AS ForaSLA
FROM Tickets t
    JOIN TicketCat c ON c.ID = t.TicketCatID
    JOIN TicketPriority p ON p.ID = t.TicketPriorityID
    JOIN SLA s ON s.ID = t.SlaID
WHERE t.DataFecho IS NOT NULL
GROUP BY c.Descricao, p.Descricao
ORDER BY TicketsFechados DESC;

-- Ticket state history // USE ID OF TICKET YOU WANT TO CHECK
SELECT
    h.TicketID,
    h.DataAlteracao,
    e.Descricao AS Estado,
    COALESCE(u.Nome, te.Nome) AS AlteradoPor,
    h.Observacao
FROM TicketEstadoHistorico h
    JOIN TicketEstados e ON e.ID = h.EstadoID
    LEFT JOIN Users u ON u.ID = h.UserID
    LEFT JOIN Techs te ON te.ID = h.TechID
WHERE h.TicketID = 7
ORDER BY h.DataAlteracao;
GO