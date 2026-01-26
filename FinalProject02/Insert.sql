USE Projecto;
GO

------------------------------------------------------------
-- BASE LOOKUP DATA (NO FKs)
------------------------------------------------------------

-- Categorias
INSERT INTO TicketCat
        (Descricao)
VALUES
        ('Incident'),
        ('Problem'),
        ('Change Request'),
        ('Service Request');

-- Estados
INSERT INTO TicketEstados
        (Descricao)
VALUES
        ('New'),
        -- ID = 1
        ('Assigned'),
        -- 2
        ('In Progress'),
        -- 3
        ('Resolved'),
        -- 4
        ('Closed');
-- 5

-- Prioridades
INSERT INTO TicketPriority
        (Descricao)
VALUES
        ('Low'),
        ('Medium'),
        ('High'),
        ('Critical');

-- Técnicos
INSERT INTO Techs
        (Nome, Username, Email, Telf)
VALUES
        ('Manuel Joao', 'mjoao', 'mjoao@fabit.example.com', '912345678'),
        -- ID = 1
        ('Henrique Ribeiro', 'hribeiro', 'hribeiro@fabit.example.com', '913456789'),
        -- ID = 2
        ('Otavio Teixeira', 'oteixeira', 'oteixeira@fabit.example.com', '914567890'),
        -- ID = 3
        ('Pedro Lopes', 'plopes', 'plopes@fabit.example.com', '915678901');
-- ID = 4

-- Unidades organizacionais
INSERT INTO OrgUnits
        (Cliente, Departamento, Email, Telf)
VALUES
        ('Acme SA', 'IT', 'it@acme.example.com', '223000001'),
        -- ID = 1
        ('Acme SA', 'Financeiro', 'financas@acme.example.com', '223000002'),
        -- 2
        ('GlobalTech Lda', 'Operacoes', 'operacoes@globaltech.example.com', '223100001'),
        -- 3
        ('GlobalTech Lda', 'Recursos Humanos', 'rh@globaltech.example.com', '223100002');
-- 4

------------------------------------------------------------
-- USERS (COM FK PARA OrgUnits)
------------------------------------------------------------

INSERT INTO Users
        (Nome, Username, Email, Telf, OrgUnitID)
VALUES
        -- OrgUnitID = 1  ('Acme SA', 'IT')
        ('Bruno Maia', 'bmaia', 'bmaia@acme.example.com', '300800801', 1),
        -- ID ~ 1
        ('Luis Ferreira', 'lferreira', 'lferreira@acme.example.com', '300800802', 1),
        -- 2
        ('Carlos Santos', 'csantos', 'csantos@acme.example.com', '300800803', 1),
        -- 3
        ('Joana Pereira', 'jpereira', 'jpereira@acme.example.com', '300800804', 1),
        -- 4
        -- OrgUnitID = 2  ('Acme SA', 'Financeiro')
        ('Ana Silva', 'asilva', 'asilva@acme.example.com', '301800801', 2),
        -- 5
        ('Rui Costa', 'rcosta', 'rcosta@acme.example.com', '301800802', 2),
        -- 6
        ('Marta Gomes', 'mgomes', 'mgomes@acme.example.com', '301800803', 2),
        -- 7
        ('Pedro Nunes', 'pnunes', 'pnunes@acme.example.com', '301800804', 2),
        -- 8
        -- OrgUnitID = 3  ('GlobalTech Lda', 'Operacoes')
        (N'Tainá Ferreira', 'tferreira', 'tferreira@globaltech.example.com', '302800801', 3),
        -- 9
        ('Andrey Rodrigues', 'arodrigues', 'arodrigues@globaltech.example.com', '302800802', 3),
        -- 10
        ('Miguel Lopes', 'mlopes', 'mlopes@globaltech.example.com', '302800803', 3),
        -- 11
        ('Sara Pinto', 'spinto', 'spinto@globaltech.example.com', '302800804', 3),
        -- 12
        -- OrgUnitID = 4  ('GlobalTech Lda', 'Recursos Humanos')
        ('Paula Sousa', 'psousa', 'psousa@globaltech.example.com', '303800801', 4),
        -- 13
        ('Nuno Barros', 'nbarros', 'nbarros@globaltech.example.com', '303800802', 4),
        -- 14
        ('Rita Carvalho', 'rcarvalho', 'rcarvalho@globaltech.example.com', '303800803', 4);
-- 15

------------------------------------------------------------
-- SLAs (Categoria × Prioridade) - IDs 1..16
------------------------------------------------------------

INSERT INTO SLA
        (TicketCatID, TicketPriorityID, TempoMaxPrimeiraRespostaMin, TempoMaxResolucao)
VALUES
        -- Incident (TicketCatID = 1)
        (1, 1, 240, 1440),
        (1, 2, 120, 720),
        (1, 3, 60, 240),
        (1, 4, 30, 120),
        -- Problem (2)
        (2, 1, 480, 2880),
        (2, 2, 240, 1440),
        (2, 3, 120, 720),
        (2, 4, 60, 360),
        -- Change Request (3)
        (3, 1, 480, 2880),
        (3, 2, 240, 1440),
        (3, 3, 120, 720),
        (3, 4, 60, 360),
        -- Service Request (4)
        (4, 1, 480, 2880),
        (4, 2, 240, 1440),
        (4, 3, 120, 720),
        (4, 4, 60, 360);

------------------------------------------------------------
-- TICKETS (MIX: ASSIGNED, IN PROGRESS, RESOLVED, CLOSED, UNASSIGNED)
------------------------------------------------------------
-- Lembra:
-- Estado 1=New, 2=Assigned, 3=In Progress, 4=Resolved, 5=Closed
-- TechID: 1=Manuel, 2=Henrique, 3=Otavio, 4=Pedro

-- Ticket 1: Incident, High, New (unassigned)
INSERT INTO Tickets
        (Assunto, Descricao, UserID, TechID, TicketCatID, TicketPriorityID, SlaID, EstadoAtualID)
VALUES
        ('Email down for finance', 'Users in Finance cannot access email.',
                5, NULL, 1, 3, NULL, 1);

-- Ticket 2: Incident, Critical, Assigned to Manuel
INSERT INTO Tickets
        (Assunto, Descricao, UserID, TechID, TicketCatID, TicketPriorityID, SlaID, EstadoAtualID)
VALUES
        ('Core switch failure', 'Network down in HQ.',
                1, 1, 1, 4, NULL, 2);

-- Ticket 3: Service Request, Low, New (unassigned)
INSERT INTO Tickets
        (Assunto, Descricao, UserID, TechID, TicketCatID, TicketPriorityID, SlaID, EstadoAtualID)
VALUES
        ('New laptop request', 'Requesting a new laptop for new hire.',
                8, NULL, 4, 1, NULL, 1);

-- Ticket 4: Problem, Medium, In Progress with Henrique
INSERT INTO Tickets
        (Assunto, Descricao, UserID, TechID, TicketCatID, TicketPriorityID, SlaID, EstadoAtualID)
VALUES
        ('Intermittent VPN issues', 'VPN drops connection randomly.',
                3, 2, 2, 2, NULL, 3);

-- Ticket 5: Change Request, High, Assigned to Pedro
INSERT INTO Tickets
        (Assunto, Descricao, UserID, TechID, TicketCatID, TicketPriorityID, SlaID, EstadoAtualID)
VALUES
        ('Upgrade database server', 'Upgrade SQL Server to latest version.',
                10, 4, 3, 3, NULL, 2);

-- Ticket 6: Incident, High, Resolved within SLA (Manuel)
INSERT INTO Tickets
        (Assunto, Descricao, DataAbertura, DataFecho,
        UserID, TechID, TicketCatID, TicketPriorityID, SlaID, EstadoAtualID)
VALUES
        ('Email issue - finance', 'Email slow for some users.',
                '2026-01-20T09:00:00', '2026-01-20T11:00:00',
                5, 1, 1, 3, NULL, 4);

-- Ticket 7: Incident, High, Resolved outside SLA (Henrique)
INSERT INTO Tickets
        (Assunto, Descricao, DataAbertura, DataFecho,
        UserID, TechID, TicketCatID, TicketPriorityID, SlaID, EstadoAtualID)
VALUES
        ('VPN down - HQ', 'VPN unavailable for all users.',
                '2026-01-20T09:00:00', '2026-01-20T15:00:00',
                3, 2, 1, 3, NULL, 4);

-- Ticket 8: Incident, Medium, Assigned to Otavio
INSERT INTO Tickets
        (Assunto, Descricao, UserID, TechID, TicketCatID, TicketPriorityID, SlaID, EstadoAtualID)
VALUES
        ('Wi-Fi issues in HR', 'HR users report unstable Wi-Fi connection.',
                14, 3, 1, 2, NULL, 2);

-- Ticket 9: Service Request, Medium, In Progress with Otavio
INSERT INTO Tickets
        (Assunto, Descricao, UserID, TechID, TicketCatID, TicketPriorityID, SlaID, EstadoAtualID)
VALUES
        ('Shared folder access', 'Need new shared folder for project X.',
                9, 3, 4, 2, NULL, 3);

-- Ticket 10: Change Request, High, Resolved by Otavio
INSERT INTO Tickets
        (Assunto, Descricao, DataAbertura, DataFecho,
        UserID, TechID, TicketCatID, TicketPriorityID, SlaID, EstadoAtualID)
VALUES
        ('Implement password policy change', 'Update AD password policy to new standard.',
                '2026-01-21T09:00:00', '2026-01-21T12:00:00',
                11, 3, 3, 3, NULL, 4);

-- Ticket 11: Service Request, Critical, Closed by Pedro
INSERT INTO Tickets
        (Assunto, Descricao, DataAbertura, DataFecho,
        UserID, TechID, TicketCatID, TicketPriorityID, SlaID, EstadoAtualID)
VALUES
        ('Onboarding access for new hires', 'Provision all required systems for new employees.',
                '2026-01-19T08:30:00', '2026-01-19T10:00:00',
                13, 4, 4, 4, NULL, 5);

-- Ticket 12: Incident, Low, New (unassigned)
INSERT INTO Tickets
        (Assunto, Descricao, UserID, TechID, TicketCatID, TicketPriorityID, SlaID, EstadoAtualID)
VALUES
        ('Printer jam on floor 2', 'Printer frequently jamming.',
                7, NULL, 1, 1, NULL, 1);

-- Ticket 13: Problem, Critical, In Progress with Manuel
INSERT INTO Tickets
        (Assunto, Descricao, UserID, TechID, TicketCatID, TicketPriorityID, SlaID, EstadoAtualID)
VALUES
        ('Database performance degradation', 'Slow queries on reporting database.',
                2, 1, 2, 4, NULL, 3);

-- Ticket 14: Change Request, Medium, New (unassigned)
INSERT INTO Tickets
        (Assunto, Descricao, UserID, TechID, TicketCatID, TicketPriorityID, SlaID, EstadoAtualID)
VALUES
        ('Deploy new HR portal', 'Rollout new HR self-service portal.',
                13, NULL, 3, 2, NULL, 1);

-- Ticket 15: Service Request, Medium, Assigned to Henrique
INSERT INTO Tickets
        (Assunto, Descricao, UserID, TechID, TicketCatID, TicketPriorityID, SlaID, EstadoAtualID)
VALUES
        ('Setup shared mailbox', 'Create shared mailbox for support team.',
                1, 2, 4, 2, NULL, 2);

------------------------------------------------------------
-- TICKET STATE HISTORY (TicketEstadoHistorico)
------------------------------------------------------------

-- Ticket 1: New
INSERT INTO TicketEstadoHistorico
        (TicketID, EstadoID, UserID, TechID, Observacao)
VALUES
        (1, 1, 5, NULL, 'Ticket criado pelo utilizador.');

-- Ticket 2: New -> Assigned
INSERT INTO TicketEstadoHistorico
        (TicketID, EstadoID, UserID, TechID, Observacao)
VALUES
        (2, 1, 1, NULL, 'Ticket criado pelo utilizador.'),
        (2, 2, NULL, 1, 'Ticket atribuido a Manuel Joao.');

-- Ticket 3: New
INSERT INTO TicketEstadoHistorico
        (TicketID, EstadoID, UserID, TechID, Observacao)
VALUES
        (3, 1, 8, NULL, 'Pedido de novo equipamento.');

-- Ticket 4: New -> Assigned -> In Progress
INSERT INTO TicketEstadoHistorico
        (TicketID, EstadoID, UserID, TechID, Observacao)
VALUES
        (4, 1, 3, NULL, 'Ticket criado pelo utilizador.'),
        (4, 2, NULL, 2, 'Ticket atribuido a Henrique Ribeiro.'),
        (4, 3, NULL, 2, 'Analise tecnica em curso.');

-- Ticket 5: New -> Assigned
INSERT INTO TicketEstadoHistorico
        (TicketID, EstadoID, UserID, TechID, Observacao)
VALUES
        (5, 1, 10, NULL, 'Pedido de change request.'),
        (5, 2, NULL, 4, 'Ticket atribuido a Pedro Lopes.');

-- Ticket 6: New -> Assigned -> In Progress -> Resolved (dentro SLA)
INSERT INTO TicketEstadoHistorico
        (TicketID, EstadoID, DataAlteracao, UserID, TechID, Observacao)
VALUES
        (6, 1, '2026-01-20T09:00:00', 5, NULL, 'Ticket criado pelo utilizador.'),
        (6, 2, '2026-01-20T09:15:00', NULL, 1, 'Atribuido a Manuel.'),
        (6, 3, '2026-01-20T09:30:00', NULL, 1, 'Analise em curso.'),
        (6, 4, '2026-01-20T11:00:00', NULL, 1, 'Resolvido dentro do SLA.');

-- Ticket 7: New -> Assigned -> In Progress -> Resolved (fora SLA)
INSERT INTO TicketEstadoHistorico
        (TicketID, EstadoID, DataAlteracao, UserID, TechID, Observacao)
VALUES
        (7, 1, '2026-01-20T09:00:00', 3, NULL, 'Ticket criado pelo utilizador.'),
        (7, 2, '2026-01-20T10:00:00', NULL, 2, 'Atribuido a Henrique.'),
        (7, 3, '2026-01-20T11:00:00', NULL, 2, 'Analise em curso.'),
        (7, 4, '2026-01-20T15:00:00', NULL, 2, 'Resolvido fora do SLA.');

-- Ticket 8 (Otavio): New -> Assigned
INSERT INTO TicketEstadoHistorico
        (TicketID, EstadoID, UserID, TechID, Observacao)
VALUES
        (8, 1, 14, NULL, 'Ticket criado pelo utilizador.'),
        (8, 2, NULL, 3, 'Ticket atribuido a Otavio Teixeira.');

-- Ticket 9 (Otavio): New -> Assigned -> In Progress
INSERT INTO TicketEstadoHistorico
        (TicketID, EstadoID, UserID, TechID, Observacao)
VALUES
        (9, 1, 9, NULL, 'Ticket criado pelo utilizador.'),
        (9, 2, NULL, 3, 'Ticket atribuido a Otavio Teixeira.'),
        (9, 3, NULL, 3, 'Otavio iniciou a intervencao.');

-- Ticket 10 (Otavio): New -> Assigned -> In Progress -> Resolved
INSERT INTO TicketEstadoHistorico
        (TicketID, EstadoID, DataAlteracao, UserID, TechID, Observacao)
VALUES
        (10, 1, '2026-01-21T09:00:00', 11, NULL, 'Ticket criado pelo utilizador.'),
        (10, 2, '2026-01-21T09:10:00', NULL, 3, 'Atribuido a Otavio.'),
        (10, 3, '2026-01-21T09:30:00', NULL, 3, 'Implementacao em curso.'),
        (10, 4, '2026-01-21T12:00:00', NULL, 3, 'Alteracao concluida.');

-- Ticket 11 (Pedro): New -> Assigned -> In Progress -> Closed
INSERT INTO TicketEstadoHistorico
        (TicketID, EstadoID, DataAlteracao, UserID, TechID, Observacao)
VALUES
        (11, 1, '2026-01-19T08:30:00', 13, NULL, 'Ticket criado pelo utilizador.'),
        (11, 2, '2026-01-19T08:45:00', NULL, 4, 'Atribuido a Pedro.'),
        (11, 3, '2026-01-19T09:00:00', NULL, 4, 'Trabalho em curso.'),
        (11, 5, '2026-01-19T10:00:00', NULL, 4, 'Ticket encerrado.');

-- Ticket 12: New
INSERT INTO TicketEstadoHistorico
        (TicketID, EstadoID, UserID, TechID, Observacao)
VALUES
        (12, 1, 7, NULL, 'Ticket criado pelo utilizador.');

-- Ticket 13 (Manuel): New -> Assigned -> In Progress
INSERT INTO TicketEstadoHistorico
        (TicketID, EstadoID, UserID, TechID, Observacao)
VALUES
        (13, 1, 2, NULL, 'Ticket criado pelo utilizador.'),
        (13, 2, NULL, 1, 'Ticket atribuido a Manuel.'),
        (13, 3, NULL, 1, 'Analise de performance em curso.');

-- Ticket 14: New
INSERT INTO TicketEstadoHistorico
        (TicketID, EstadoID, UserID, TechID, Observacao)
VALUES
        (14, 1, 13, NULL, 'Pedido de rollout de portal de RH.');

-- Ticket 15 (Henrique): New -> Assigned
INSERT INTO TicketEstadoHistorico
        (TicketID, EstadoID, UserID, TechID, Observacao)
VALUES
        (15, 1, 1, NULL, 'Ticket criado pelo utilizador.'),
        (15, 2, NULL, 2, 'Ticket atribuido a Henrique.');

------------------------------------------------------------
-- INTERVENÇÕES (TicketIntervencao)
------------------------------------------------------------

INSERT INTO TicketIntervencao
        (TicketID, TechID, DataHora, Descricao, Notas, Tempo)
VALUES
        -- Ticket 2, Manuel
        (2, 1, '2026-01-19T10:00:00', 'Diagnostico inicial ao switch core.', 'Identificado modulo avariado.', 45),
        (2, 1, '2026-01-19T11:00:00', 'Substituicao do modulo e testes.', 'Servico restabelecido.', 60),

        -- Ticket 4, Henrique
        (4, 2, '2026-01-19T14:00:00', 'Recolha de logs de VPN.', 'Logs enviados para equipa de rede.', 30),
        (4, 2, '2026-01-19T15:00:00', 'Ajuste de configuracao no firewall.', 'Timeout aumentado.', 40),

        -- Ticket 5, Pedro
        (5, 4, '2026-01-20T09:30:00', 'Planeamento da janela de manutencao.', 'Acordado downtime com negocio.', 35),

        -- Ticket 6, Manuel
        (6, 1, '2026-01-20T09:30:00', 'Diagnostico email.', 'Problema no servidor de mail.', 30),
        (6, 1, '2026-01-20T10:15:00', 'Aplicacao de correcao.', 'Servico normalizado.', 45),

        -- Ticket 7, Henrique
        (7, 2, '2026-01-20T11:00:00', 'Diagnostico VPN.', 'Causa identificada na firewall.', 60),
        (7, 2, '2026-01-20T14:00:00', 'Alteracao de configuracao.', 'Regras ajustadas.', 90),

        -- Ticket 8, Otavio
        (8, 3, '2026-01-21T10:00:00', 'Analise de APs em HR.', 'Ajuste de canais Wi-Fi.', 40),
        (8, 3, '2026-01-21T11:00:00', 'Teste de conectividade.', 'Ligacao estabilizada.', 30),

        -- Ticket 9, Otavio
        (9, 3, '2026-01-22T09:30:00', 'Criacao de pasta partilhada.', 'Permissoes definidas para equipa.', 45),
        (9, 3, '2026-01-22T10:15:00', 'Testes com utilizadores.', 'Acesso validado.', 30),

        -- Ticket 10, Otavio
        (10, 3, '2026-01-21T09:30:00', 'Analise requisitos de politica.', 'Requisitos revistos com equipa de seguranca.', 60),
        (10, 3, '2026-01-21T10:45:00', 'Aplicacao de nova politica.', 'Politica aplicada e forcada.', 75),

        -- Ticket 11, Pedro
        (11, 4, '2026-01-19T08:45:00', 'Recolha de requisitos de onboarding.', 'Lista de sistemas validada.', 30),
        (11, 4, '2026-01-19T09:15:00', 'Provisionamento de acessos.', 'Todos os acessos criados.', 45),

        -- Ticket 13, Manuel
        (13, 1, '2026-01-21T13:00:00', 'Rever planos de execucao.', 'Indices candidatos identificados.', 50),
        (13, 1, '2026-01-21T14:00:00', 'Aplicar tunning inicial.', 'Melhorias observadas.', 40),

        -- Ticket 15, Henrique
        (15, 2, '2026-01-22T11:00:00', 'Criacao de mailbox partilhado.', 'Configurado em Exchange.', 35);
GO
