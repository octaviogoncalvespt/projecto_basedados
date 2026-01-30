USE Projeto;
GO

-- (TicketCat)
INSERT INTO TicketCat
        (Descricao)
VALUES
        ('Incident'),
        ('Problem'),
        ('Change Request'),
        ('Service Request');

-- (TicketEstados)
INSERT INTO TicketEstados
        (Descricao)
VALUES
        ('New'),
        ('Assigned'),
        ('In Progress'),
        ('Resolved'),
        ('Closed');

-- (TicketPriority)
INSERT INTO TicketPriority
        (Descricao)
VALUES
        ('Low'),
        ('Medium'),
        ('High'),
        ('Critical');

-- (Techs)
INSERT INTO Techs
        (Nome, Username, Email, Telf)
VALUES
        ('Manuel Joao', 'mjoao', 'mjoao@fabit.example.com', '912345678'),
        ('Henrique Ribeiro', 'hribeiro', 'hribeiro@fabit.example.com', '913456789'),
        ('Otavio Teixeira', 'oteixeira', 'oteixeira@fabit.example.com', '914567890'),
        ('Pedro Lopes', 'plopes', 'plopes@fabit.example.com', '915678901');

-- (OrgUnits)
INSERT INTO OrgUnits
        (Cliente, Departamento, Email, Telf)
VALUES
        ('Acme SA', 'IT', 'it@acme.example.com', '223000001'),
        ('Acme SA', 'Financeiro', 'financas@acme.example.com', '223000002'),
        ('GlobalTech Lda', 'Operacoes', 'operacoes@globaltech.example.com', '223100001'),
        ('GlobalTech Lda', 'Recursos Humanos', 'rh@globaltech.example.com', '223100002');

-- (Users)
INSERT INTO Users
        (Nome, Username, Email, Telf, OrgUnitID)
VALUES
        ('Bruno Maia', 'bmaia', 'bmaia@acme.example.com', '300800801', 1),
        ('Luis Ferreira', 'lferreira', 'lferreira@acme.example.com', '300800802', 1),
        ('Carlos Santos', 'csantos', 'csantos@acme.example.com', '300800803', 1),
        ('Joana Pereira', 'jpereira', 'jpereira@acme.example.com', '300800804', 1),
        ('Ana Silva', 'asilva', 'asilva@acme.example.com', '301800801', 2),
        ('Rui Costa', 'rcosta', 'rcosta@acme.example.com', '301800802', 2),
        ('Marta Gomes', 'mgomes', 'mgomes@acme.example.com', '301800803', 2),
        ('Pedro Nunes', 'pnunes', 'pnunes@acme.example.com', '301800804', 2),
        (N'Tainá Ferreira', 'tferreira', 'tferreira@globaltech.example.com', '302800801', 3),
        ('Andrey Rodrigues', 'arodrigues', 'arodrigues@globaltech.example.com', '302800802', 3),
        ('Miguel Lopes', 'mlopes', 'mlopes@globaltech.example.com', '302800803', 3),
        ('Sara Pinto', 'spinto', 'spinto@globaltech.example.com', '302800804', 3),
        ('Paula Sousa', 'psousa', 'psousa@globaltech.example.com', '303800801', 4),
        ('Nuno Barros', 'nbarros', 'nbarros@globaltech.example.com', '303800802', 4),
        ('Rita Carvalho', 'rcarvalho', 'rcarvalho@globaltech.example.com', '303800803', 4);

-- (SLA)
INSERT INTO SLA
        (TicketCatID, TicketPriorityID, TempoMaxPrimeiraRespostaMin, TempoMaxResolucao)
VALUES
        (1, 1, 240, 1440),
        (1, 2, 120, 720),
        (1, 3, 60, 240),
        (1, 4, 30, 120),
        (2, 1, 480, 2880),
        (2, 2, 240, 1440),
        (2, 3, 120, 720),
        (2, 4, 60, 360),
        (3, 1, 480, 2880),
        (3, 2, 240, 1440),
        (3, 3, 120, 720),
        (3, 4, 60, 360),
        (4, 1, 480, 2880),
        (4, 2, 240, 1440),
        (4, 3, 120, 720),
        (4, 4, 60, 360);

-- (Tickets)
INSERT INTO Tickets
        (Assunto, Descricao, UserID, TechID, TicketCatID, TicketPriorityID, SlaID, EstadoAtualID)
VALUES
        ('Email down for finance', 'Users in Finance cannot access email.', 5, NULL, 1, 3, NULL, 1),
        ('Core switch failure', 'Network down in HQ.', 1, 1, 1, 4, NULL, 2),
        ('New laptop request', 'Requesting a new laptop for new hire.', 8, NULL, 4, 1, NULL, 1),
        ('Intermittent VPN issues', 'VPN drops connection randomly.', 3, 2, 2, 2, NULL, 3),
        ('Upgrade database server', 'Upgrade SQL Server to latest version.', 10, 4, 3, 3, NULL, 2);

INSERT INTO Tickets
        (Assunto, Descricao, DataAbertura, DataFecho, UserID, TechID, TicketCatID, TicketPriorityID, SlaID, EstadoAtualID)
VALUES
        ('Email issue - finance', 'Email slow for some users.', '2026-01-20T09:00:00', '2026-01-20T11:00:00', 5, 1, 1, 3, NULL, 4),
        ('VPN down - HQ', 'VPN unavailable for all users.', '2026-01-20T09:00:00', '2026-01-20T15:00:00', 3, 2, 1, 3, NULL, 4),
        ('Implement password policy change', 'Update AD password policy to new standard.', '2026-01-21T09:00:00', '2026-01-21T12:00:00', 11, 3, 3, 3, NULL, 4),
        ('Onboarding access for new hires', 'Provision all required systems for new employees.', '2026-01-19T08:30:00', '2026-01-19T10:00:00', 13, 4, 4, 4, NULL, 5);

INSERT INTO Tickets
        (Assunto, Descricao, UserID, TechID, TicketCatID, TicketPriorityID, SlaID, EstadoAtualID)
VALUES
        ('Wi-Fi issues in HR', 'HR users report unstable Wi-Fi connection.', 14, 3, 1, 2, NULL, 2),
        ('Shared folder access', 'Need new shared folder for project X.', 9, 3, 4, 2, NULL, 3),
        ('Printer jam on floor 2', 'Printer frequently jamming.', 7, NULL, 1, 1, NULL, 1),
        ('Database performance degradation', 'Slow queries on reporting database.', 2, 1, 2, 4, NULL, 3),
        ('Deploy new HR portal', 'Rollout new HR self-service portal.', 13, NULL, 3, 2, NULL, 1),
        ('Setup shared mailbox', 'Create shared mailbox for support team.', 1, 2, 4, 2, NULL, 2);

-- (TicketEstadoHistorico)
INSERT INTO TicketEstadoHistorico
        (TicketID, EstadoID, UserID, TechID, Observacao)
VALUES
        (1, 1, 5, NULL, 'Ticket criado pelo utilizador.');

INSERT INTO TicketEstadoHistorico
        (TicketID, EstadoID, UserID, TechID, Observacao)
VALUES
        (2, 1, 1, NULL, 'Ticket criado pelo utilizador.'),
        (2, 2, NULL, 1, 'Ticket atribuido a Manuel Joao.');

INSERT INTO TicketEstadoHistorico
        (TicketID, EstadoID, UserID, TechID, Observacao)
VALUES
        (3, 1, 8, NULL, 'Pedido de novo equipamento.');

INSERT INTO TicketEstadoHistorico
        (TicketID, EstadoID, UserID, TechID, Observacao)
VALUES
        (4, 1, 3, NULL, 'Ticket criado pelo utilizador.'),
        (4, 2, NULL, 2, 'Ticket atribuido a Henrique Ribeiro.'),
        (4, 3, NULL, 2, 'Analise tecnica em curso.');

-- (TicketIntervencao)
INSERT INTO TicketIntervencao
        (TicketID, TechID, DataHora, Descricao, Notas, Tempo)
VALUES
        (2, 1, '2026-01-19T10:00:00', 'Diagnostico inicial ao switch core.', 'Identificado modulo avariado.', 45),
        (2, 1, '2026-01-19T11:00:00', 'Substituicao do modulo e testes.', 'Servico restabelecido.', 60),
        (4, 2, '2026-01-19T14:00:00', 'Recolha de logs de VPN.', 'Logs enviados para equipa de rede.', 30),
        (4, 2, '2026-01-19T15:00:00', 'Ajuste de configuracao no firewall.', 'Timeout aumentado.', 40),
        (5, 4, '2026-01-20T09:30:00', 'Planeamento da janela de manutencao.', 'Acordado downtime com negocio.', 35),
        (6, 1, '2026-01-20T09:30:00', 'Diagnostico email.', 'Problema no servidor de mail.', 30),
        (6, 1, '2026-01-20T10:15:00', 'Aplicacao de correcao.', 'Servico normalizado.', 45),
        (7, 2, '2026-01-20T11:00:00', 'Diagnostico VPN.', 'Causa identificada na firewall.', 60),
        (7, 2, '2026-01-20T14:00:00', 'Alteracao de configuracao.', 'Regras ajustadas.', 90),
        (8, 3, '2026-01-21T10:00:00', 'Analise de APs em HR.', 'Ajuste de canais Wi-Fi.', 40),
        (8, 3, '2026-01-21T11:00:00', 'Teste de conectividade.', 'Ligacao estabilizada.', 30),
        (9, 3, '2026-01-22T09:30:00', 'Criacao de pasta partilhada.', 'Permissoes definidas para equipa.', 45),
        (9, 3, '2026-01-22T10:15:00', 'Testes com utilizadores.', 'Acesso validado.', 30),
        (10, 3, '2026-01-21T09:30:00', 'Analise requisitos de politica.', 'Requisitos revistos com equipa de seguranca.', 60),
        (10, 3, '2026-01-21T10:45:00', 'Aplicacao de nova politica.', 'Politica aplicada e forcada.', 75),
        (11, 4, '2026-01-19T08:45:00', 'Recolha de requisitos de onboarding.', 'Lista de sistemas validada.', 30),
        (11, 4, '2026-01-19T09:15:00', 'Provisionamento de acessos.', 'Todos os acessos criados.', 45),
        (13, 1, '2026-01-21T13:00:00', 'Rever planos de execucao.', 'Indices candidatos identificados.', 50),
        (13, 1, '2026-01-21T14:00:00', 'Aplicar tunning inicial.', 'Melhorias observadas.', 40),
        (15, 2, '2026-01-22T11:00:00', 'Criacao de mailbox partilhado.', 'Configurado em Exchange.', 35);
GO
