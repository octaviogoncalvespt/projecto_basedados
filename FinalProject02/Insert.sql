USE FinalProject02;

INSERT INTO OrgUnits
    (Cliente, Departamento, Email, Telf)
VALUES
    ('POHM LDA', 'RH', 'POHM@email.com', '+351 200800800'),
    ('POHM LDA', 'Marketing', 'POHM@email.com', '+351 200800800'),
    ('POHM LDA', 'Financeiro', 'POHM@email.com', '+351 200800800'),
    ('Empresa A', '', 'empresa_a@email.com', '+351 201800800'),
    ('Empresa B', '', 'empresa_b@email.com', '+351 202800800');

INSERT INTO Techs
    (Nome, Username, Email, Telf)
VALUES
    ('Manuel Joao', 'mjoao', 'manuel.joao@POHM.com', '+351 911000001'),
    ('Henrique Ribeiro', 'hribeiro', 'henrique.ribeiro@POHM.com', '+351 911000002'),
    ('Octavio Teixeira', 'oteixeira', 'octavio.teixeira@POHM.com', '+351 911000003'),
    ('Pedro Lopes', 'plopes', 'pedro.lopes@POHM.com', '+351 911000004');

INSERT INTO TicketCat
    (Descricao)
VALUES
    ('Encomendas'),
    ('Suporte de Software/Hardware'),
    ('Faturação'),
    ('Consultoria Técnica');

INSERT INTO TicketPriority
    (Descricao)
VALUES
    ('Baixa'),
    ('Média'),
    ('Alta'),
    ('Crítica');

INSERT INTO TicketEstados
    (Descricao)
VALUES
    ('Aberto'),
    ('Em Progresso'),
    ('Resolvido'),
    ('Fechado');

INSERT INTO Users
    (Nome, Username, Email, Telf, OrgUnitID)
VALUES

    ('Luis Ferreira', 'lferreira', 'luis.ferreira@POHM.com', '300800800', 1),
    ('Andre Matos', 'amatos', 'andre.matos@POHM.com', '301800800', 2),
    ('Rita Carvalho', 'rcarvalho', 'rita.carvalho@POHM.com', '302800800', 3),
    ('Nuno Barros', 'nbarros', 'nuno.barros@POHM.com', '303800800', 1),


    ('Paula Sousa', 'psousa', 'paula.sousa@empresaa.com', '304800800', 4),
    ('Miguel Correia', 'mcorreia', 'miguel.correia@empresaa.com', '305800800', 4),

    ('Teresa Fonseca', 'tfonseca', 'teresa.fonseca@empresab.com', '306800800', 5),
    ('Bruno Neves', 'bneves', 'bruno.neves@empresab.com', '307800800', 5);

INSERT INTO Tickets
    (Assunto, Descricao, UserID, TechID, TicketCatID, TicketPriorityID, SlaID, EstadoAtualID)
VALUES

    ('Falta de faturas',
        'Falta de faturas do mês de Dezembro',
        5,
        NULL,
        2,
        3,
        7,
        1       
),


    ('Substituição de monitor',
        'Um monitor está com defeito e precisa de ser substituído.',
        7,
        NULL,
        1,
        2,
        2,
        1       
);


INSERT INTO SLAs
    (TicketCatID, TicketPriorityID, TempoMaxPrimeiraRespostaMin, TempoMaxResolucaoMin)
VALUES
    -- Problemas de Hardware (ID = 1)
    (1, 1, 240, 1440),
    -- Baixa
    (1, 2, 120, 720),
    -- Média
    (1, 3, 60, 360),
    -- Alta
    (1, 4, 30, 120),
    -- Crítica

    -- Suporte de Software (ID = 2)
    (2, 1, 240, 1440),
    -- Baixa
    (2, 2, 120, 720),
    -- Média
    (2, 3, 60, 360),
    -- Alta
    (2, 4, 30, 120),
    -- Crítica

    -- Acesso e Permissões (ID = 3)
    (3, 1, 240, 1440),
    -- Baixa
    (3, 2, 120, 720),
    -- Média
    (3, 3, 60, 360),
    -- Alta
    (3, 4, 30, 120);    -- Crítica

