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

-- Specific Selects --

-- Open Tickets
SELECT *
FROM Tickets
WHERE EstadoAtualID = 1;

-- Closed Tickets
SELECT *
FROM Tickets
WHERE EstadoAtualID = 5;

-- Tickets assigned to a specific Tech
SELECT *
FROM Tickets
WHERE TechID = 2;

-- All Techs who worked on a specific Ticket // USE ID OF TICKET YOU WANT TO CHECK
SELECT TicketEstadoHistorico.TicketID, TicketEstadoHistorico.EstadoID, Techs.Nome
FROM TicketEstadoHistorico
    JOIN Techs ON TicketEstadoHistorico.TechID = Techs.ID
WHERE TicketEstadoHistorico.TicketID = 4;

-- Users who have tickets and how many
SELECT
    Tickets.UserID,
    Users.Nome AS Name,
    COUNT(*) AS TicketCount
FROM Tickets
    JOIN Users ON Tickets.UserID = Users.ID
GROUP BY Tickets.UserID, Users.Nome;

-- Interventions for a specific Ticket
SELECT *
FROM TicketIntervencao
WHERE TicketID = 7;

-- High Priority Open Tickets
SELECT *
FROM Tickets t
WHERE t.EstadoAtualID BETWEEN 1 AND 3
ORDER BY t.TicketPriorityID DESC;

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